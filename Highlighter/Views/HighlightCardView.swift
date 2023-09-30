//
//  HighlightCardView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/29/23.
//

import SwiftUI

struct HighlightCardView: View {
    @Binding var highlight: Highlight
    
    var body: some View {
        VStack {
            Text("Source: \(highlight.source)")
            Text("Content: \(highlight.content)")
//            HStack {
//                ForEach(highlight.labels) { label in
//                    LabelView(label: label)
//                }
//            }
            
        }
    }
}

#Preview {
    HighlightCardView(highlight: .constant(Highlight.sampleData[0]))
}
