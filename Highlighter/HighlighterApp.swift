//
//  HighlighterApp.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI

@main
struct HighlighterApp: App {
    @StateObject private var store = HighlightStore()
    
    var body: some Scene {
        WindowGroup {
            HighlightsView(highlights: $store.highlights) {
                Task {
                    do {
                        try await store.save(highlights: store.highlights)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
