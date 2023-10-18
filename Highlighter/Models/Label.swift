//
//  Label.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/22/23.
//

import Foundation

class Label: Identifiable, Equatable, Hashable, ObservableObject, CustomStringConvertible, Codable {
    let id: UUID
    var name: String
    var theme: Theme
    @Published var isFiltered: Bool
    
    init(id: UUID = UUID(), name: String, theme: Theme = .sky, isFiltered: Bool = false) {
        self.id = id
        self.name = name
        self.theme = theme
        self.isFiltered = isFiltered
    }
    
    public static func ==(lhs: Label, rhs: Label) -> Bool {
        return lhs.name == rhs.name
    }
    
    public static func ==(lhs: String, rhs: Label) -> Bool {
        return lhs == rhs.name
    }
    
    public static func ==(lhs: Label, rhs: String) -> Bool {
        return lhs.name == rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var description: String {
        return self.name
    }
    
    enum CodingKeys: String, CodingKey {
            case id, name, theme, isFiltered
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(theme, forKey: .theme)
            try container.encode(isFiltered, forKey: .isFiltered)
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            theme = try container.decode(Theme.self, forKey: .theme)
            isFiltered = try container.decode(Bool.self, forKey: .isFiltered)
        }
}

extension Label {
    static let sampleData = Labels(items: [
        Label(name: "News", theme: .bubblegum),
        Label(name: "Inspiration", theme: .indigo),
        Label(name: "Interesting", theme: .buttercup),
        Label(name: "Science", theme: .teal),
        Label(name: "Math", theme: .periwinkle),
        Label(name: "Wow", theme: .sky),
        Label(name: "Computer", theme: .navy),
        Label(name: "Classic", theme: .poppy)
    ])
    
    static let sampleData1 = Labels(items:[
        Label(name: "News", theme: .bubblegum),
        Label(name: "Inspiration", theme: .indigo),
        Label(name: "Computer", theme: .navy),
        Label(name: "Classic", theme: .poppy)
    ])
    
    static let sampleData2 = Labels(items: [
        Label(name: "Computer", theme: .navy),
        Label(name: "Classic", theme: .poppy)
    ])
    
    static let empty = Label(name: "", theme: .sky)
}

class Labels: ObservableObject {
    @Published var items = [Label]()
    
    init(items: [Label]) {
        self.items = items
    }
}
