//
//  HighlighterApp.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI
import SwiftData

@main
struct HighlighterApp: App {
    @State var highlights: [Highlight] = Highlight.sampleData
    
    var body: some Scene {
        WindowGroup {
            HighlightsView(highlights: $highlights)
        }
    }
}
