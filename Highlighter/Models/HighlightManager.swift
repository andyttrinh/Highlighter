//
//  HighlightManager.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/23/23.
//

import Foundation

class HighlightManager: ObservableObject {
    @Published var highlight: Highlight

    init(highlight: Highlight) {
        self.highlight = highlight
    }

    func addNewLabel(name: String) {
        let newLabel = Label(name: name)
        highlight.labels.append(newLabel)
    }
}

