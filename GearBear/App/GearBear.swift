// filepath: /Users/robinwyffels/Desktop/GearBear/GearBear/App/GearBear.swift
//
//  GearBear.swift
//  GearBear
//
//  Created by Robin Wyffels on 08/05/2025.
//

import SwiftUI

@main
struct GearBear: App {
    init() {
        UINavigationBar.appearance().overrideUserInterfaceStyle = .light
    }
    var body: some Scene {
        WindowGroup {
            UserSelectView()
                .preferredColorScheme(.light)
                //.background(Color.AppBackground.edgesIgnoringSafeArea(.all))
        }
    }
}
