//
//  Highlight.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import Foundation

public class Highlight: Codable, Identifiable, ObservableObject {
    public let id: UUID
    public var source: String
    public var content: String
    public var date: Date
    @Published public var labels: [Label]?

    public init(id: UUID = UUID(), source: String, content: String, date: Date = Date.now, labels: [Label]) {
        self.id = id
        self.source = source
        self.content = content
        self.date = date
        self.labels = labels
    }
    
    enum CodingKeys: String, CodingKey {
            case id, source, content, date, labels
        }
        
    public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(source, forKey: .source)
            try container.encode(content, forKey: .content)
            try container.encode(date, forKey: .date)
            try container.encode(labels, forKey: .labels)
        }
        
    required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            source = try container.decode(String.self, forKey: .source)
            content = try container.decode(String.self, forKey: .content)
            date = try container.decode(Date.self, forKey: .date)
            
            // Using decodeIfPresent for the labels key
            labels = try container.decodeIfPresent([Label].self, forKey: .labels) ?? []
        }

}

extension Highlight {
    public static let sampleData: Highlights = Highlights(items: [
        Highlight(source: "Martin Luther King Jr", content: "I have a dream that my four little children will one day live in a nation where they will not be judged by the color of their skin but by the content of their character.", labels: Label.sampleData.items),
        Highlight(source: "Abraham Lincoln", content: "You can fool all of the people some of the time, and some of the people all of the time, but you can't fool all of the people all of the time.", labels: Label.sampleData1.items),
        Highlight(source: "Mahatma Gandhi", content: "You must be the change you wish to see in the world.", labels: Label.sampleData2.items)
    ])
    
    public static let empty = Highlight(source: "", content: "", labels: [])
    public static func makeEmptyHighlight() -> Highlight { Highlight(source: "", content: "", labels: [])}
}

public class Highlights: ObservableObject {
    @Published public var items = [Highlight]()
    
    public init(items: [Highlight]) {
        self.items = items
        self.items.sort(by: {$0.date > $1.date})
    }
    
    public func add(item: Highlight) {
        self.items.insert(item, at: 0)
    }
    
    public func replaceItems(items: [Highlight]) {
        self.items = items
        self.items.sort(by: {$0.date > $1.date})
    }
}
