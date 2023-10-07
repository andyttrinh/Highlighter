//
//  LabelView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/29/23.
//

import SwiftUI

struct LabelCardView: View {
    var label: Label
    var body: some View {
        Text(label.name)
            .padding(8)
//            .frame(maxWidth: .infinity)
            .background(label.theme.mainColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .foregroundStyle(label.theme.accentColor)
    }
}

#Preview {
    LabelCardView(label: Highlight.sampleData[0].labels[0])
}
