//
//  Highlight.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import Foundation

class Highlight: Identifiable {
    let id: UUID
    var source: String
    var content: String

    init(id: UUID = UUID(), source: String, content: String) {
        self.id = id
        self.source = source
        self.content = content
    }
}

extension Highlight {
    static let sampleData: [Highlight] = [
        Highlight(source: "Instapaper", content: "This is content from Instapaper")
    ]
    
    static let empty = Highlight(source: "", content: "")
}
