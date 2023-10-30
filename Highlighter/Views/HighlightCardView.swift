//
//  HighlightCardView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/29/23.
//

import SwiftUI
import HighlighterShared


struct HighlightCardView: View {
    @ObservedObject var highlight: Highlight
    
    var body: some View {
        ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 380, height: 170)
              .background(.white)
              .cornerRadius(20)
              .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                  .inset(by: 0.5)
                  .stroke(Color(red: 0.83, green: 0.86, blue: 0.87), lineWidth: 1)
              )
            
            VStack {
                Text("\(highlight.source)")
                  .font(
                    Font.custom("Poppins", size: 16)
                      .weight(.bold)
                  )
                  .foregroundColor(Color(red: 0.22, green: 0.28, blue: 0.31))
                  .frame(width: 329, alignment: .topLeading)
                Spacer()
                Text("\(highlight.content)")
                  .font(Font.custom("Poppins", size: 14))
                  .foregroundColor(Color(red: 0.22, green: 0.28, blue: 0.31))
                  .frame(width: 337, alignment: .topLeading)
                Spacer()
                HStack {
                    HStack(spacing: -12) {
                        ForEach(highlight.labels!) { label in
                            LabelCubeView(label: label)
                        }
                    }
                    Spacer()
                    Image(.highlightCardNextArrow)
                }
            }
            .frame(width: 340, height: 130)
        }
        .frame(width: 380, height: 170)
    }
}

#Preview {
    HighlightCardView(highlight: Highlight.sampleData.items[0])
}
