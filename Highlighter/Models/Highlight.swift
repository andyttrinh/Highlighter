//
//  Highlight.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import Foundation

class Highlight: Codable, Identifiable, ObservableObject {
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
    
    enum CodingKeys: String, CodingKey {
            case id, source, content, labels
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(source, forKey: .source)
            try container.encode(content, forKey: .content)
            try container.encode(labels, forKey: .labels)
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            source = try container.decode(String.self, forKey: .source)
            content = try container.decode(String.self, forKey: .content)
            labels = try container.decode([Label].self, forKey: .labels)
        }
}

extension Highlight {
    static let sampleData: Highlights = Highlights(items: [
        Highlight(source: "Martin Luther King Jr", content: "I have a dream that my four little children will one day live in a nation where they will not be judged by the color of their skin but by the content of their character.", labels: Label.sampleData.items),
        Highlight(source: "Abraham Lincoln", content: "You can fool all of the people some of the time, and some of the people all of the time, but you can't fool all of the people all of the time.", labels: Label.sampleData1.items),
        Highlight(source: "Mahatma Gandhi", content: "You must be the change you wish to see in the world.", labels: Label.sampleData2.items)
    ])
    
    static let empty = Highlight(source: "", content: "", labels: [])
    static func makeEmptyHighlight() -> Highlight { Highlight(source: "", content: "", labels: [])}
}

class Highlights: ObservableObject {
    @Published var items = [Highlight]()
    
    init(items: [Highlight]) {
        self.items = items
    }
}
