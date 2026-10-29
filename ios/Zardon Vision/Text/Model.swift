//
//  Model.swift
//  Zardon Vision
//
//  Created by Alaap Joshi on 5/13/23.
//

import Foundation

class TextItem: Identifiable {
    var id: String
    var text: String = ""
    
    init() {
        id = UUID().uuidString
    }
}


class RecognizedContent: ObservableObject {
    @Published var items = [TextItem]()
}
