//
//  EditHighlightView.swift
//  HighlighterShareExtension
//
//  Created by Andy Trinh on 10/24/23.
//

import SwiftUI
import Firebase
import HighlighterShared


struct EditHighlightView: View {
    @ObservedObject var highlight: Highlight
    @ObservedObject var globalLabels: Labels
    @State private var animate: Bool = false
    @State var selectedLabel: HighlighterShared.Label = HighlighterShared.Label.sampleData.items[0]
    var isNewHighlight: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Info")){
                TextField("Source", text: $highlight.source)
                TextField("Content", text: $highlight.content, axis: .vertical)
            }
            Section(header: Text("Labels")) {
                ForEach(highlight.labels!) { label in
                    LabelCardView(label: label)
//                    Text("\(label.name)")
                }
                .onDelete { indeces in
                    // Delete label from highlight
                    highlight.labels!.remove(atOffsets: indeces)
                    // Then update the entire labels key in firebase
                    if (!isNewHighlight) {
                        updateHighlightLabels(highlightID: highlight.id, newLabels: highlight.labels!) { error in
                            if let error = error {
                                    print("Failed to add label: \(error.localizedDescription)")
                                } else {
                                    print("HighlighterShared.Label successfully deleted!")
                                }
                        }
                    }
                }
                HStack {
                    Button(action: addNewLabel) {
                        Text("Add Label")
                    }
                    Picker("", selection: $selectedLabel) {
                        ForEach(globalLabels.items) { label in
//                            LabelCardView(label: label)
                            Text("\(label.name)")
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
                
                if (!isNewHighlight) {
                    uploadLabel(inHighlight: highlight.id, newLabel: selectedLabel) { error in
                        if let error = error {
                                print("Failed to add label: \(error.localizedDescription)")
                            } else {
                                print("HighlighterShared.Label successfully added!")
                            }
                    }
                }
            }
        }
    
    // Will probably want to refactor this code to avoid redundancy since it appears Label views as well - Andy
    func updateHighlightLabels(highlightID: UUID, newLabels: [HighlighterShared.Label], completion: @escaping (Error?) -> Void) {
        let dbRef = Database.database().reference().child("highlights").child(highlightID.uuidString).child("labels")
        
        // Convert the array of HighlighterShared.Label instances to an array of dictionaries
        let labelsData: [[String: Any]] = newLabels.compactMap { label in
            return label.toDictionary()
        }
        
        // Update the entire 'labels' child with the new array of label data
        dbRef.setValue(labelsData) { error, _ in
            completion(error)
        }
    }
    
    func uploadLabel(inHighlight highlightID: UUID, newLabel: HighlighterShared.Label, completion: @escaping (Error?) -> Void) {
        let dbRef = Database.database().reference().child("highlights").child(highlightID.uuidString).child("labels")
        
        // Fetch the current labels from the database
        dbRef.observeSingleEvent(of: .value) { (snapshot) in
            var currentLabels: [[String: Any]] = []
            
            if let existingLabels = snapshot.value as? [[String: Any]] {
                currentLabels = existingLabels
            }
            
            // Convert the new HighlighterShared.Label instance to a dictionary
            guard let labelData = newLabel.toDictionary() else {
                completion(NSError(domain: "HighlighterApp", code: 1001, userInfo: ["message": "Failed to encode HighlighterShared.Label."]))
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

}

//#Preview {
//    EditHighlightView(highlight: Highlight.sampleData.items[0], globalLabels: HighlighterShared.Label.sampleData)
//}
