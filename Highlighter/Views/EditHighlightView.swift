//
//  EditHighlightView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI

struct EditHighlightView: View {
    @Binding var highlight: Highlight
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
            }
        }
}

#Preview {
    EditHighlightView(highlight: .constant(Highlight.sampleData[0]))
}
