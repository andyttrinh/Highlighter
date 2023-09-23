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
    var labels: [Label]

    init(id: UUID = UUID(), source: String, content: String, labels: [Label]) {
        self.id = id
        self.source = source
        self.content = content
        self.labels = labels
    }
}

extension Highlight {
    static let sampleData: [Highlight] = [
        Highlight(source: "Instapaper", content: "This is content from Instapaper", labels: Label.sampleData)
    ]
    
    static let empty = Highlight(source: "", content: "", labels: [])
}
