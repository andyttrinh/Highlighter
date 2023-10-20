//
//  Label.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/22/23.
//

import Foundation

public class Label: Identifiable, Equatable, Hashable, ObservableObject, CustomStringConvertible, Codable {
    public let id: UUID
    public var name: String
    public var theme: Theme
    @Published public var isFiltered: Bool
    
    public init(id: UUID = UUID(), name: String, theme: Theme = .sky, isFiltered: Bool = false) {
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
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var description: String {
        return self.name
    }
    
    public enum CodingKeys: String, CodingKey {
            case id, name, theme, isFiltered
        }
        
    public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(theme, forKey: .theme)
            try container.encode(isFiltered, forKey: .isFiltered)
        }
        
    required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            theme = try container.decode(Theme.self, forKey: .theme)
            isFiltered = try container.decode(Bool.self, forKey: .isFiltered)
        }
}

extension Label {
    public static let sampleData = Labels(items: [
        Label(name: "News", theme: .bubblegum),
        Label(name: "Inspiration", theme: .indigo),
        Label(name: "Interesting", theme: .buttercup),
        Label(name: "Science", theme: .teal),
        Label(name: "Math", theme: .periwinkle),
        Label(name: "Wow", theme: .sky),
        Label(name: "Computer", theme: .navy),
        Label(name: "Classic", theme: .poppy)
    ])
    
    public static let sampleData1 = Labels(items:[
        Label(name: "News", theme: .bubblegum),
        Label(name: "Inspiration", theme: .indigo),
        Label(name: "Computer", theme: .navy),
        Label(name: "Classic", theme: .poppy)
    ])
    
    public static let sampleData2 = Labels(items: [
        Label(name: "Computer", theme: .navy),
        Label(name: "Classic", theme: .poppy)
    ])
    
    public static let empty = Label(name: "", theme: .sky)
}

extension Label {
    public func toDictionary() -> [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: [])
        return jsonObject as? [String: Any]
    }
}

public class Labels: ObservableObject {
    @Published public var items = [Label]()
    
    public init(items: [Label]) {
        self.items = items
    }
}
