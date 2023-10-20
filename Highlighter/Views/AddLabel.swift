//
//  AddLabel.swift
//  Highlighter
//
//  Created by Andy Trinh on 10/7/23.
//

import SwiftUI
import HighlighterShared

struct AddLabel: View {
    @State private var newLabelName: String = ""
    @State private var themeSelection: Theme = .sky
    var body: some View {
        VStack {
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
    
    private func addNewLabel() {
           // Need to add to global labels - Andy
        }
}

#Preview {
    AddLabel()
}
