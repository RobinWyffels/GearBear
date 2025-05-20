//
//  Athlete.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import Foundation

struct Athlete: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
}

//"Athlete": [{ 
//    "id:": 1, 
//    "name": "Ulysse",
//    }], 