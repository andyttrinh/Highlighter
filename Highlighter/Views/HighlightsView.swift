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
    @State var isPresentingNewFilterView = false
    @State var labelFilter: [Label] = []
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach($highlights.filter { highlight in filterFunc(highlight: highlight.wrappedValue)}) {$highlight in
                    NavigationLink(destination: EditHighlightView(highlight: $highlight)){
                        HighlightCardView(highlight: $highlight)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        highlights.remove(at: index)
                    }
                })
                
            }
            .toolbar {
                Button(action: {
                    isPresentingNewHighlightView = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: {isPresentingNewFilterView = true}) {
                        Text("Filter")
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingNewHighlightView) {
            NewHighlightView(
                highlights: $highlights,
                isPresentingNewHighlightView: $isPresentingNewHighlightView)
        }
        .sheet(isPresented: $isPresentingNewFilterView) {
            LabelsView(filterLabels: $labelFilter)
        }
        .onChange(of: scenePhase) { oldCount, newCount in
            if newCount == .inactive { saveAction() }
        }
    }
    
    private func filterFunc(highlight: Highlight) -> Bool {
        return labelFilter.allSatisfy(highlight.labels.contains(_:))
    }
}

#Preview {
    HighlightsView(highlights: .constant(Highlight.sampleData), saveAction: {})
}
