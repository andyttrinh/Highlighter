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
    @Binding var filterLabels: [Label]
    var body: some View {
        Form {
            Section(header: Text("Labels")) {
                ForEach(filterLabels) { label in
                    LabelCardView(label: label)
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
    //            ThemePicker(selection: $themeSelection)
            }
        }
    }
    
    private func addNewLabel() {
            withAnimation {
                if !newLabelName.isEmpty {
                    let newLabel = Label(name: newLabelName)
                    filterLabels.append(newLabel)
                    newLabelName = ""
                }
            }
        }
}

#Preview {
    LabelsView(filterLabels: .constant(Label.sampleData))
}
