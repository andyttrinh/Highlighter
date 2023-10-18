//
//  ContentView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI
import Firebase

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
                        let highlightIdToBeRemoved = highlights.items[index].id
                        highlights.items.remove(at: index)
                        // delete from firebase 
                        deleteHighlight(withId: highlightIdToBeRemoved) { error in
                            if let error = error {
                                    print("Failed to delete highlight: \(error.localizedDescription)")
                                } else {
                                    print("Highlight successfully deleted!")
                                }
                        }
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
    
    func deleteHighlight(withId id: UUID, completion: @escaping (Error?) -> Void) {
        let dbRef = Database.database().reference().child("highlights").child(id.uuidString)
        
        dbRef.removeValue { error, _ in
            completion(error)
        }
    }

}

#Preview {
    HighlightsView(highlights: Highlight.sampleData)
}
