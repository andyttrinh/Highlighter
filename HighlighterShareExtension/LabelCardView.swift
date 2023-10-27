//
//  LabelCardView.swift
//  HighlighterShareExtension
//
//  Created by Andy Trinh on 10/26/23.
//

import SwiftUI
import HighlighterShared

struct LabelCardView: View {
    var label: HighlighterShared.Label
    var body: some View {
        Text(label.name)
            .padding(8)
//            .frame(maxWidth: .infinity)
            .background(label.theme.mainColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .foregroundStyle(label.theme.accentColor)
    }
}


