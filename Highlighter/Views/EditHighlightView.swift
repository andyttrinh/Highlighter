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
    @State var selectedLabel: Label = Label.sampleData[0]
    @State private var themeSelection: Theme = .sky
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
                        ForEach(Label.sampleData) { label in
                            LabelCardView(label: label)
                                .tag(label)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
            }
        }
    }
    private func addNewLabel() {
            // Animation is broken need to fix - Andy
            withAnimation {
                highlight.labels.append(selectedLabel)
            }
        }
}

#Preview {
    EditHighlightView(highlight: .constant(Highlight.sampleData[0]))
}
