//
//  FilterView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/30/23.
//
//
import SwiftUI

struct LabelsView: View {
    @State private var newLabelName: String = ""
    @State private var themeSelection: Theme = .sky
    @State private var toggleVar: Bool = false
    @ObservedObject var globalLabels: Labels
    @Binding var filterLabels: [Label]
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
                    filterLabels.remove(atOffsets: indeces)
                }
                HStack {
                    Section(header: Text("Add Label")) {
                        TextField("Enter Label Name", text: $newLabelName)
                        Button(action: addNewLabel) {
                            Text("Add Label")
                        }
                    }
                }
                ThemePicker(selection: $themeSelection)
            }
        }
    }
    
    private func addNewLabel() {
            withAnimation {
                if !newLabelName.isEmpty {
                    let newLabel = Label(name: newLabelName)
                    globalLabels.items.append(newLabel)
                    newLabelName = ""
                }
            }
        }
}

#Preview {
    LabelsView(globalLabels: Label.sampleData, filterLabels: .constant([]))
}
