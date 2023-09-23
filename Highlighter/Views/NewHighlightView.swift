//
//  NewHighlightView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI

struct NewHighlightView: View {
    @State var newHighlight: Highlight = Highlight.empty
    @Binding var highlights: [Highlight]
    @Binding var isPresentingNewHighlightView: Bool
    var body: some View {
        NavigationStack {
            EditHighlightView(highlight: $newHighlight)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewHighlightView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            highlights.append(newHighlight)
                            isPresentingNewHighlightView = false
                        }
                    }
                }

        }
    }
}

#Preview {
    NewHighlightView(highlights: .constant(Highlight.sampleData), isPresentingNewHighlightView: .constant(true))
}
