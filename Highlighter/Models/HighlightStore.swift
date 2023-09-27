//
//  HighlightStore.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/27/23.
//

import SwiftUI

@MainActor
class HighlightStore: ObservableObject {
    @Published var highlights: [Highlight] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: false)
        .appendingPathComponent("highlight.data")
    }
    
    func load() async throws {
        let task = Task<[Highlight], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let highlightData = try JSONDecoder().decode([Highlight].self, from: data)
            return highlightData
        }
        
        let highlights = try await task.value
        self.highlights = highlights
    }
    
    func save(highlights: [Highlight]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(highlights)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}
