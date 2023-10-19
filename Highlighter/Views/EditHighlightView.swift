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
                ForEach(highlight.labels!) { label in
                    LabelCardView(label: label)
                }
                .onDelete { indeces in
                    for index in indeces {
                        deleteLabel(fromHighlight: highlight.id, labelIdx: index) { error in
                            if let error = error {
                                    print("Failed to add label: \(error.localizedDescription)")
                                } else {
                                    print("Label successfully deleted!")
                                }
                        }
                    }
                    highlight.labels!.remove(atOffsets: indeces)
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
                highlight.labels!.append(selectedLabel)
                // Should probebly make highlight.labels observable somehow to remove this var - Andy
                animate = !animate
                
                updateLabels(inHighlight: highlight.id, newLabel: selectedLabel) { error in
                    if let error = error {
                            print("Failed to add label: \(error.localizedDescription)")
                        } else {
                            print("Label successfully added!")
                        }
                }
            }
        }
    
    func updateLabels(inHighlight highlightID: UUID, newLabel: Label, completion: @escaping (Error?) -> Void) {
        let dbRef = Database.database().reference().child("highlights").child(highlightID.uuidString).child("labels")
        
        // Fetch the current labels from the database
        dbRef.observeSingleEvent(of: .value) { (snapshot) in
            var currentLabels: [[String: Any]] = []
            
            if let existingLabels = snapshot.value as? [[String: Any]] {
                currentLabels = existingLabels
            }
            
            // Convert the new Label instance to a dictionary
            guard let labelData = newLabel.toDictionary() else {
                completion(NSError(domain: "HighlighterApp", code: 1001, userInfo: ["message": "Failed to encode Label."]))
                return
            }
            
            // Append the new label to the current labels
            currentLabels.append(labelData)
            
            // Write the entire modified labels array back to the database
            dbRef.setValue(currentLabels) { error, _ in
                completion(error)
            }
        }
    }
    
    func deleteLabel(fromHighlight highlightID: UUID, labelIdx: Int, completion: @escaping (Error?) -> Void) {
        // Reference to the specific label within a highlight
        let labelRef = Database.database().reference()
            .child("highlights")
            .child(highlightID.uuidString)
            .child("labels")
            .child(String(labelIdx))

        // Remove the label from Firebase
        labelRef.removeValue { error, _ in
            completion(error)
        }
    }


}

#Preview {
    EditHighlightView(highlight: Highlight.sampleData.items[0])
}
