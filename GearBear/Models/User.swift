//
//  User.swift
//  GearBear
//
//  Created by Robin Wyffels on 08/05/2025.
//

import Foundation

struct User: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let avatar: String
}
