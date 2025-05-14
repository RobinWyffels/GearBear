//
//  PageWithNavBar.swift
//  GearBear
//
//  Created by Robin Wyffels on 14/05/2025.
//

import SwiftUI

struct PageWithNavBar<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                content
                    .padding(.bottom, 80) // Space for navbar
            }
            BottomNavBar()
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
