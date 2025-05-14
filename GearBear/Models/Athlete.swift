//
//  Athlete.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import Foundation

struct Athlete: Identifiable, Decodable {
    let id: Int
    let name: String
    let avatar: String
}

//"Athlete": [{ 
//    "id:": 1, 
//    "name": "Ulysse", 
//    "avatar": "UlysseIcon" 
//    }], 