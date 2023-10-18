//
//  HighlightCardView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/29/23.
//

import SwiftUI

struct HighlightCardView: View {
    @ObservedObject var highlight: Highlight
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(highlight.content)")
            Spacer()
            HStack {
                HStack () {
                    ForEach(highlight.labels) { label in
                        LabelCardView(label: label)
    //                        .scaleEffect(0.1)
                            .frame(width: 1, height: 1)
                    }
                }
                Spacer()
                Text("\(highlight.source)")

            }
            Spacer()
            
        }
    }
}

#Preview {
    HighlightCardView(highlight: Highlight.sampleData.items[0])
}
