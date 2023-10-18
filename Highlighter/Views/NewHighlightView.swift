//
//  NewHighlightView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI

struct NewHighlightView: View {
    @ObservedObject var newHighlight: Highlight = Highlight.makeEmptyHighlight()
    @ObservedObject var highlights: Highlights
    @Binding var isPresentingNewHighlightView: Bool
    var body: some View {
        NavigationStack {
            EditHighlightView(highlight: newHighlight)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewHighlightView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            highlights.items.append(newHighlight)
                            isPresentingNewHighlightView = false
                        }
                    }
                }

        }
    }
}

#Preview {
    NewHighlightView(highlights: Highlight.sampleData, isPresentingNewHighlightView: .constant(true))
}
