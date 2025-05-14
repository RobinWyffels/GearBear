//
//  BottomNavBar.swift
//  GearBear
//
//  Created by Robin Wyffels on 14/05/2025.
//

import SwiftUI

struct BottomNavBar: View {
    var qrAction: () -> Void = {}
    var leftAction: () -> Void = {}
    var rightAction: () -> Void = {}

    var body: some View {
        HStack {
            // Left custom button (replace with your custom icon)
            Button(action: leftAction) {
                Image(systemName: "skis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
            }
            .frame(maxWidth: .infinity)

            // QR code button (center)
            Button(action: qrAction) {
                Image(systemName: "qrcode.viewfinder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
            }
            .frame(maxWidth: .infinity)

            // Calendar with plus button (right)
            Button(action: rightAction) {
                Image(systemName: "calendar.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 24)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.MainAppColor, Color.SecondaryAppColor]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 0))
    }
}
