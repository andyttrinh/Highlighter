//
//  NewHighlightView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI
import Firebase
import HighlighterShared

struct NewHighlightView: View {
    @ObservedObject var newHighlight: Highlight = Highlight.makeEmptyHighlight()
    @ObservedObject var highlights: Highlights
    @ObservedObject var globalLabels: Labels
    @Binding var isPresentingNewHighlightView: Bool

    var body: some View {
        NavigationStack {
            EditHighlightView(highlight: newHighlight, globalLabels: globalLabels, isNewHighlight: true)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewHighlightView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            highlights.add(item: newHighlight)
                            storeHighlight(highlight: newHighlight)
                            isPresentingNewHighlightView = false
                        }
                    }
                }

        }
    }
    
    func storeHighlight(highlight: Highlight) {
        let dbRef = Database.database().reference()
        let highlightRef = dbRef.child("highlights").child(highlight.id.uuidString)
        
        do {
            let data = try JSONEncoder().encode(highlight)
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                highlightRef.setValue(json)
            }
        } catch {
            print("Error encoding highlight: \(error)")
        }
    }
}

#Preview {
    NewHighlightView(highlights: Highlight.sampleData, globalLabels: HighlighterShared.Label.sampleData, isPresentingNewHighlightView: .constant(true))
}
