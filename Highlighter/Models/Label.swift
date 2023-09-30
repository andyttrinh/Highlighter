//
//  Label.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/22/23.
//

import Foundation

class Label: Identifiable, Codable {
    let id: UUID
    var name: String
    var theme: Theme
    
    init(id: UUID = UUID(), name: String, theme: Theme) {
        self.id = id
        self.name = name
        self.theme = theme
    }
    
}

extension Label {
    static let sampleData = [
        Label(name: "News", theme: .bubblegum),
        Label(name: "Inspiration", theme: .indigo)
    ]
    
    static let empty = Label(name: "", theme: .sky)
}
