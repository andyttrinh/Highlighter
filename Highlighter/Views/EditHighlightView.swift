//
//  EditHighlightView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI

struct EditHighlightView: View {
    @Binding var highlight: Highlight
    @State private var newLabelName: String = ""
    @State private var themeSelection: Theme = .sky
    var body: some View {
        Form {
            Section(header: Text("Info")){
                TextField("Source", text: $highlight.source)
                TextField("Content", text: $highlight.content, axis: .vertical)
            }
            
            Section(header: Text("Labels")) {
                ForEach(highlight.labels) { label in
                    Text(label.name)
                        .padding(8)
                        .background(label.theme.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .foregroundStyle(label.theme.accentColor)
                }
                .onDelete { indeces in
                    highlight.labels.remove(atOffsets: indeces)
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
                    let newLabel = Label(name: newLabelName, theme: themeSelection)
                    highlight.labels.append(newLabel)
                    newLabelName = ""
                }
            }
        }
}

#Preview {
    EditHighlightView(highlight: .constant(Highlight.sampleData[0]))
}
