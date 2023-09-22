//
//  ContentView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI
import SwiftData

struct HighlightsView: View {
//    @Environment(\.modelContext) private var context
    @Query var highlights: [Highlight]
    @State var isPresentingNewHighlightView = false
    
    var body: some View {
        NavigationStack {
            List(highlights) { highlight in
                NavigationLink(destination: EditHighlightView(highlight: highlight)){
                    Text(highlight.content)
                }
            }
            .toolbar {
                Button(action: {
//                    context.insert(Highlight(
//                        source: "Instapaper",
//                        content: "Hello my name is Andy Trinh"))
                    
                    isPresentingNewHighlightView = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewHighlightView) {
            NewHighlightView(isPresentingNewHighlightView: $isPresentingNewHighlightView)
        }
    }
}

#Preview {
    HighlightsView()
        .modelContainer(previewContainer)
}
