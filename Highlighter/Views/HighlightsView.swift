//
//  ContentView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI

struct HighlightsView: View {
    @ObservedObject var highlights: Highlights
    @Environment(\.scenePhase) private var scenePhase
    @State var isPresentingNewHighlightView = false
    @State var isPresentingNewFilterView = false
    @State var labelFilter: [Label] = []
    @ObservedObject var globalLabels = Label.sampleData
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach(highlights.items.filter { highlight in filterFunc(highlight: highlight)}) {highlight in
                    NavigationLink(destination: EditHighlightView(highlight: highlight)){
                        HighlightCardView(highlight: highlight)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        highlights.items.remove(at: index)
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
                highlights: highlights,
                isPresentingNewHighlightView: $isPresentingNewHighlightView)
        }
        .sheet(isPresented: $isPresentingNewFilterView) {
            LabelsView(globalLabels: globalLabels, filterLabels: $labelFilter)
        }
        .onChange(of: scenePhase) { oldCount, newCount in
            if newCount == .inactive {  }
        }
    }
    
    private func filterFunc(highlight: Highlight) -> Bool {
        return labelFilter.allSatisfy(highlight.labels.contains(_:))
    }
}

#Preview {
    HighlightsView(highlights: Highlight.sampleData)
}
