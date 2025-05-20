//
//  PageWithNavBar.swift
//  GearBear
//
//  Created by Robin Wyffels on 14/05/2025.
//

import SwiftUI

struct PageWithNavBar<Content: View>: View {
    let content: Content
    var rightAction: () -> Void = {}
    var qrAction: () -> Void = {}


    init(rightAction: @escaping () -> Void = {}, qrAction: @escaping () -> Void = {}, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.rightAction = rightAction
        self.qrAction = qrAction
    }

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                content
                    .padding(.bottom, 80)
            }
            BottomNavBar(qrAction: qrAction, rightAction: rightAction)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
