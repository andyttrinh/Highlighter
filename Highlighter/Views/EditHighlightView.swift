//
//  EditHighlightView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI
import Firebase

struct EditHighlightView: View {
    @ObservedObject var highlight: Highlight
    @State private var animate: Bool = false
    @State var selectedLabel: Label = Label.sampleData.items[0]
    var body: some View {
        Form {
            Section(header: Text("Info")){
                TextField("Source", text: $highlight.source)
                TextField("Content", text: $highlight.content, axis: .vertical)
            }
            Section(header: Text("Labels")) {
                ForEach(highlight.labels) { label in
                    LabelCardView(label: label)
                }
                .onDelete { indeces in
                    highlight.labels.remove(atOffsets: indeces)
                }
                HStack {
                    Button(action: addNewLabel) {
                        Text("Add Label")
                    }
                    Picker("", selection: $selectedLabel) {
                        ForEach(Label.sampleData.items) { label in
                            LabelCardView(label: label)
                                .tag(label)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
        }
    }
    private func addNewLabel() {
            withAnimation {
                highlight.labels.append(selectedLabel)
                // Should probebly make highlight.labels observable somehow to remove this var - Andy
                animate = !animate
                
                addLabelToStoreHighlight(toHighlight: highlight.id, label: selectedLabel) { error in
                    if let error = error {
                            print("Failed to add label: \(error.localizedDescription)")
                        } else {
                            print("Label successfully added!")
                        }
                }
            }
        }
    
    func addLabelToStoreHighlight(toHighlight highlightID: UUID, label: Label, completion: @escaping (Error?) -> Void) {
        let dbRef = Database.database().reference().child("highlights").child(highlightID.uuidString).child("labels")

        // Convert the Label instance to a dictionary
        guard let labelData = label.toDictionary() else {
            completion(NSError(domain: "HighlighterApp", code: 1001, userInfo: ["message": "Failed to encode Label."]))
            return
        }

        // Create a new child with a unique key and set its value to the label data
//       Need to convert labels to a map
        let newLabelRef = dbRef.child("")
        newLabelRef.setValue(labelData) { error, _ in
            completion(error)
        }
    }

}

#Preview {
    EditHighlightView(highlight: Highlight.sampleData.items[0])
}
