//
//  Highlight.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import Foundation

class Highlight: Identifiable, ObservableObject {
    let id: UUID
    var source: String
    var content: String
    @Published var labels: [Label]

    init(id: UUID = UUID(), source: String, content: String, labels: [Label]) {
        self.id = id
        self.source = source
        self.content = content
        self.labels = labels
    }
}

extension Highlight {
    static let sampleData: [Highlight] = [
        Highlight(source: "Instapaper", content: "This is content from Instapaper", labels: Label.sampleData.items),
        Highlight(source: "CNN", content: "President Biden is protesting with UAW", labels: Label.sampleData1.items),
        Highlight(source: "Youtube", content: "Mr Beast made a Squid Game Videoooo", labels: Label.sampleData2.items)
    ]
    
    static let empty = Highlight(source: "", content: "", labels: [])
}
