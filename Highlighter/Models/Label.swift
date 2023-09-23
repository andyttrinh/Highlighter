//
//  Label.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/22/23.
//

import Foundation

struct GlobalLabel {
    static var labels: [Label] = []
}

class Label: Identifiable {
    let id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
}

extension Label {
    static let sampleData = [
        Label(name: "News"),
        Label(name: "Inspiration")
    ]
    
    static let empty = Label(name: "")
}
