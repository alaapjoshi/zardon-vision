//
//  FacialReconView.swift
//  Zardon Vision
//
//  Created by Alaap Joshi on 5/13/23.
//

import SwiftUI
import AVFoundation


struct FacialReconView: View {
    let synthesizer = AVSpeechSynthesizer()
    func speak(_ message: String) {
        let utterance = AVSpeechUtterance(string: message)
        synthesizer.speak(utterance)
    }
    var body: some View {
        Text("")
        
    }
}

struct FacialReconView_Previews: PreviewProvider {
    static var previews: some View {
        FacialReconView()
    }
}
