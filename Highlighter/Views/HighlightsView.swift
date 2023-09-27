//
//  ContentView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI

struct HighlightsView: View {
    @Binding var highlights: [Highlight]
    @Environment(\.scenePhase) private var scenePhase
    @State var isPresentingNewHighlightView = false
    let saveAction: ()->Void
    
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
        .onChange(of: scenePhase) { oldCount, newCount in
            if newCount == .inactive { saveAction() }
        }
    }
}

#Preview {
    HighlightsView(highlights: .constant(Highlight.sampleData), saveAction: {})
}
