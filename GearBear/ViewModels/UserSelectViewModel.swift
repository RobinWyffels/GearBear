//
//  UserSelectViewModel.swift
//  GearBear
//
//  Created by Robin Wyffels on 08/05/2025.
//

import SwiftUI
import Foundation

class UserSelectViewModel: ObservableObject {
    @Published var users: [User] = [
        User(name: "Alex", avatar: "AlexIcon"),
        User(name: "James", avatar: "JamesIcon"),
        User(name: "Max", avatar: "MaxIcon"),
        User(name: "Quantin", avatar: "QuantIcon")
    ]
    
    @Published var SelectedUser: User? = nil
}
