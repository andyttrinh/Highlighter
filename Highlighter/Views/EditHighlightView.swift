//
//  EditHighlightView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI

struct EditHighlightView: View {
    @Binding var highlight: Highlight
    var body: some View {
        Form {
            Section(header: Text("Info")){
                TextField("Source", text: $highlight.source)
                TextField("Content", text: $highlight.content, axis: .vertical)
            }
            
            Section(header: Text("Labels")) {
                ForEach(highlight.labels) { label in
                    Text(label.name)
                }
                AddLabel(highlight: $highlight)
            }
        }

    }
}

#Preview {
    EditHighlightView(highlight: .constant(Highlight.sampleData[0]))
}
