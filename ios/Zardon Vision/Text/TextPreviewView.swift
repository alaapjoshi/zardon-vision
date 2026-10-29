//
//  TextPreviewView.swift
//  Zardon Vision
//
//  Created by Alaap Joshi on 5/13/23.
//

import SwiftUI
import AVFoundation
struct TextPreviewView: View {
    var text: String
    @State private var text2 = ""
    let synthesizer = AVSpeechSynthesizer()

    
    var body: some View {
        VStack {
            ScrollView {
                Text(text)
                    .font(.body)
                    .padding()
            }
            .onAppear {
                            let utterance = AVSpeechUtterance(string: self.text)
                                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                self.synthesizer.speak(utterance)
                            }
        }
    }
}

struct TextPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        TextPreviewView(text: "")
    }
}
