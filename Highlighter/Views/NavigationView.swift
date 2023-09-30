//
//  NavigationView.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/30/23.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        TabView {
            Text("a")
                .tabItem() {
                    Image(systemName: "phone.fill")
                    Text("Home")
                }
            
            Text("b")
                .tabItem() {
                    Image(systemName: "phone.fill")
                    Text("Home")
                }
        }
    }
}

#Preview {
    NavigationView()
}
