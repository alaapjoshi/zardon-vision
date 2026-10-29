//
//  CameraView.swift
//  Zardon Vision
//
//  Created by Alaap Joshi on 5/13/23.
//

import UIKit
import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {

    @Binding var capturedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.capturedImage = image
                parent.presentationMode.wrappedValue.dismiss()
                
                guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                    print("Failed to convert UIImage to Data")
                    return
                }
                
                let url = URL(string: "http://192.168.0.111:20100/saveimage")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                
                let boundary = UUID().uuidString
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                
                let formData = NSMutableData()
                formData.append("--\(boundary)\r\n".data(using: .utf8)!)
                formData.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                formData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                formData.append(imageData)
                formData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
                
                request.httpBody = formData as Data
                
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print("Error sending image to server: \(error.localizedDescription)")
                    }
                    guard let data = data else {
                        print("No data received from server")
                        return
                    }
                    if let responseString = String(data: data, encoding: .utf8) {

                        print("Server response: \(responseString)")
                        let synthesizer = AVSpeechSynthesizer()

                            // create a new instance of AVSpeechUtterance with the responseString
                            let utterance = AVSpeechUtterance(string: responseString)

                            // set the speech voice and rate
                            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                            utterance.rate = AVSpeechUtteranceDefaultSpeechRate

                            // call the speak method of the synthesizer instance to speak out loud
                            synthesizer.speak(utterance)
    

                    }
                }
                task.resume()
            }
        }

        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
