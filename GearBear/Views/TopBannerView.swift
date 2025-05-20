//
//  TopBannerView.swift
//  GearBear
//
//  Created by Robin Wyffels on 14/05/2025.
//

import SwiftUI

struct TopBannerView: View {
    let showBackArrow: Bool
    let onBack: (() -> Void)?
    var personAction: () -> Void = {}

    @Environment(\.dismiss) private var dismiss

    var settingsAction: () -> Void = {}

    var body: some View {
        HStack {
            if showBackArrow {
                Button(action: {
                    onBack?()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 28, height: 24)
                        .foregroundColor(Color.PrimaryText)
                        .padding(.trailing, 32)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                // Invisible placeholder for balance
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 28, height: 24)
                    .opacity(0)
                    .padding(.trailing, 32)

            }

            Text("GearBear")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.PrimaryText)
                .padding(.horizontal)

            Button(action: personAction) {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color.PrimaryText)
            }
            Button(action: settingsAction) {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color.PrimaryText)
                    .padding(.leading, 4)
            }
        }
        .padding(.top, 45)
    }
}
