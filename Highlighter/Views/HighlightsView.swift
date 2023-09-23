//
//  ContentView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI

struct HighlightsView: View {
    @Binding var highlights: [Highlight]
    @State var isPresentingNewHighlightView = false
    
    var body: some View {
        NavigationStack {
            List($highlights) { $highlight in
                NavigationLink(destination: EditHighlightView(highlight: $highlight)){
                    Text(highlight.content)
                }
            }
            .toolbar {
                Button(action: {
                    
                    
                    isPresentingNewHighlightView = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewHighlightView) {
            NewHighlightView(
                highlights: $highlights,
                isPresentingNewHighlightView: $isPresentingNewHighlightView)
        }
    }
}

#Preview {
    HighlightsView(highlights: .constant(Highlight.sampleData))
}
