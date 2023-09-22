//
//  NewHighlightView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI
import SwiftData

struct NewHighlightView: View {
    @Environment(\.modelContext) private var context
    @Bindable var highlight: Highlight = Highlight.empty
    @Binding var isPresentingNewHighlightView: Bool
    var body: some View {
        NavigationStack {
            EditHighlightView(highlight: highlight)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewHighlightView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            context.insert(highlight)
                            isPresentingNewHighlightView = false
                        }
                    }
                }

        }
    }
}

//#Preview {
//    NewHighlightView()
//}
