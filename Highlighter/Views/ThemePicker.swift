//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Andy Trinh on 9/19/23.
//

import SwiftUI
import HighlighterShared

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.wheel)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}
