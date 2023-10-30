//
//  LabelCubeView.swift
//  Highlighter
//
//  Created by Andy Trinh on 10/27/23.
//

import SwiftUI
import HighlighterShared

struct LabelCubeView: View {
    var label: HighlighterShared.Label
    
    var body: some View {
        Rectangle()
            .foregroundColor(label.theme.mainColor)
          .frame(width: 24, height: 24)
          .background()
          .cornerRadius(8)
          .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 0)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .inset(by: 0.5)
              .stroke(.white, lineWidth: 1)
          )
    }
}

#Preview {
    LabelCubeView(label: Label.sampleData.items[0])
}
