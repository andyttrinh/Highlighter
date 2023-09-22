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
    var body: some Scene {
        WindowGroup {
            HighlightsView()
                .modelContainer(for: [Highlight.self])
        }
    }
}
