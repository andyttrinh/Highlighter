//
//  Label.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/22/23.
//

import Foundation

class Label: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var name: String
    var theme: Theme
    
    init(id: UUID = UUID(), name: String, theme: Theme = .sky) {
        self.id = id
        self.name = name
        self.theme = theme
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
}

extension Label {
    static let sampleData = [
        Label(name: "News", theme: .bubblegum),
        Label(name: "Inspiration", theme: .indigo),
        Label(name: "Interesting", theme: .buttercup),
        Label(name: "Science", theme: .teal),
        Label(name: "Math", theme: .periwinkle),
        Label(name: "Wow", theme: .sky),
        Label(name: "Computer", theme: .navy),
        Label(name: "Classic", theme: .poppy)
    ]
    
    static let sampleData1 = [
        Label(name: "News", theme: .bubblegum),
        Label(name: "Inspiration", theme: .indigo),
        Label(name: "Computer", theme: .navy),
        Label(name: "Classic", theme: .poppy)
    ]
    
    static let sampleData2 = [
        Label(name: "Computer", theme: .navy),
        Label(name: "Classic", theme: .poppy)
    ]
    
    static let empty = Label(name: "", theme: .sky)
}
