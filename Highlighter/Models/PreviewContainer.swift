//
//  PreviewContainer.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Highlight.self
        )
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
