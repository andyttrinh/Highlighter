//
//  ContentView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI
import Firebase
import HighlighterShared

struct HighlightsView: View {
    @ObservedObject var highlights: Highlights
    @ObservedObject var globalLabels: Labels
    @State var isPresentingNewHighlightView = false
    @State var isPresentingNewFilterView = false
    @State var labelFilter: [HighlighterShared.Label] = []
    let fetchHighlights: (@escaping ([Highlight]) -> Void) -> Void
    
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach(highlights.items
                    .filter { highlight in filterFunc(highlight: highlight)}) {highlight in
                    NavigationLink(destination: EditHighlightView(highlight: highlight, globalLabels: globalLabels)){
                        HighlightCardView(highlight: highlight)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        print("\(highlights.items[index].source) being removed")
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
            .refreshable {
                await refreshData()
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
                globalLabels: globalLabels,
                isPresentingNewHighlightView: $isPresentingNewHighlightView)
        }
        .sheet(isPresented: $isPresentingNewFilterView) {
            LabelsView(globalLabels: globalLabels, filterLabels: $labelFilter)
        }
    }
    
    private func filterFunc(highlight: Highlight) -> Bool {
        return labelFilter.allSatisfy(highlight.labels!.contains(_:))
    }
    
    func deleteHighlight(withId id: UUID, completion: @escaping (Error?) -> Void) {
        let dbRef = Database.database().reference().child("highlights").child(id.uuidString)
        
        dbRef.removeValue { error, _ in
            completion(error)
        }
    }
    
    func refreshData() async {
        fetchHighlights { fetchedHighlights in
                    DispatchQueue.main.async {
                        self.highlights.replaceItems(items: fetchedHighlights)
                    }
                }
    }
    

}

#Preview {
    HighlightsView(highlights: Highlight.sampleData, globalLabels: Label.sampleData, fetchHighlights: {_ in print("Refreshed")})
}
