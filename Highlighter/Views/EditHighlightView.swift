//
//  EditHighlightView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/21/23.
//

import SwiftUI
import SwiftData

struct EditHighlightView: View {
//    @Query var labels: [Label]
    @Bindable var highlight: Highlight
    var body: some View {
        Form {
            TextField("Source", text: $highlight.source)
            TextField("Content", text: $highlight.content, axis: .vertical)
//            Picker("Add Lebel", selection: $highlight.content) {
//                ForEach(labels) { label in
//                    Text(label.name)
//                }
//            }
            
        }

    }
}

//#Preview {
//    EditHighlightView(highlight: .constant(Highlight(
//        source: "Instapaper", content: "This is the content")))
//}
