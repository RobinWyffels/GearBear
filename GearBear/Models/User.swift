//
//  User.swift
//  GearBear
//
//  Created by Robin Wyffels on 08/05/2025.
//

import Foundation

struct User: Identifiable{
    let id = UUID()
    let name: String
    let avatar: String
}
