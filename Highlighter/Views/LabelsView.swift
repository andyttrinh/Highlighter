//
//  FilterView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/30/23.
//
//
import SwiftUI
import HighlighterShared
import Firebase

struct LabelsView: View {
    @State private var newLabelName: String = ""
    @State private var themeSelection: Theme = .sky
    @State private var toggleVar: Bool = false
    @ObservedObject var globalLabels: Labels
    @Binding var filterLabels: [HighlighterShared.Label]
    var body: some View {
        Form {
            Section(header: Text("Labels")) {
                ForEach($globalLabels.items) { $label in
                    HStack {
                        LabelCardView(label: label)
                        Toggle("", isOn: $label.isFiltered)
                            .onChange(of: label.isFiltered) {oldVal, newVal in
                                if (newVal == true) {
                                    filterLabels.append(label)
                                } else {
                                    filterLabels.removeAll {$0 == label}
                                }
                                print(filterLabels)
                            }
                        
                    }
                }
                .onDelete { indeces in
                    globalLabels.items.remove(atOffsets: indeces)
                    updateGlobalLabels(newLabels: globalLabels.items) { error in
                        if let error = error {
                                print("Failed to add label: \(error.localizedDescription)")
                            } else {
                                print("Global Label successfully deleted!")
                            }
                    }
                }
                HStack {
                    Section(header: Text("Add Label")) {
                        TextField("Enter Label Name", text: $newLabelName)
                        Button(action: addNewLabel) {
                            Text("Add Label")
                        }
                    }
                }
                
            }
            
        }
        ThemePicker(selection: $themeSelection)
    }
    
    private func addNewLabel() {
            if !newLabelName.isEmpty {
                let newLabel = HighlighterShared.Label(name: newLabelName, theme: themeSelection)
                withAnimation {
                    globalLabels.items.append(newLabel)
                    newLabelName = ""
                }
                
                uploadGlobalLabel(newLabel: newLabel) { error in
                    if let error = error {
                            print("Failed to add label: \(error.localizedDescription)")
                        } else {
                            print("Global Label successfully added!")
                        }
                }
            }
        }
    
    // Will probably want to refactor this code to avoid redundancy since it appears Label views as well - Andy
    func updateGlobalLabels(newLabels: [HighlighterShared.Label], completion: @escaping (Error?) -> Void) {
        let dbRef = Database.database().reference().child("globalLabels")
        
        // Convert the array of HighlighterShared.Label instances to an array of dictionaries
        let labelsData: [[String: Any]] = newLabels.compactMap { label in
            return label.toDictionary()
        }
        
        // Update the entire 'labels' child with the new array of label data
        dbRef.setValue(labelsData) { error, _ in
            completion(error)
        }
    }
    
    func uploadGlobalLabel(newLabel: HighlighterShared.Label, completion: @escaping (Error?) -> Void) {
        let dbRef = Database.database().reference().child("globalLabels")
        
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

#Preview {
    LabelsView(globalLabels: Label.sampleData, filterLabels: .constant([]))
}
