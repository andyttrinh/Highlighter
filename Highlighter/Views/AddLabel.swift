//
//  AddLabel.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/23/23.
//

import SwiftUI

struct AddLabel: View {
    @Binding var highlight: Highlight
    @State private var newLabelName: String = ""
    var body: some View {
        HStack {
            Section(header: Text("Add Label")) {
                TextField("Enter Label Name", text: $newLabelName)
                Button(action: addNewLabel) {
                    Text("Add Label")
                }
            }
        }
    }
    
    private func addNewLabel() {
            if !newLabelName.isEmpty {
                let newLabel = Label(name: newLabelName)
                highlight.labels.append(newLabel)
                newLabelName = ""
            }
        }
}

#Preview {
    AddLabel(highlight: .constant(Highlight.sampleData[0]))
}
