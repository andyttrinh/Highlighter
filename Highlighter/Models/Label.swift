//
//  Label.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/22/23.
//

import Foundation

class Label: Identifiable, Equatable, Hashable, ObservableObject, CustomStringConvertible {
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
