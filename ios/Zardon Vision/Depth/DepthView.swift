//
//  DepthView.swift
//  Zardon Vision
//
//  Created by Alaap Joshi on 5/13/23.
//

import SwiftUI
import AVFoundation
let synthesizer = AVSpeechSynthesizer()
func speak(_ message: String) {
    let utterance = AVSpeechUtterance(string: message)
    synthesizer.speak(utterance)
}
struct DepthView: View {
    let synthesizer = AVSpeechSynthesizer()
    func speak(_ message: String) {
        let utterance = AVSpeechUtterance(string: message)
        synthesizer.speak(utterance)
    }
    var body: some View {
        Button("Opening TruDepth Streamer") {
            speak("Opening TrueDepth Streamer")
            if let url = URL(string: "myapp://") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
        }
        .font(.headline)
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(10)
        .onAppear {
                speak("Depth Perception")
                    }
    }
}

struct DepthView_Previews: PreviewProvider {
    static var previews: some View {
        DepthView()
    }
}
