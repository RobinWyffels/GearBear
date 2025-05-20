//
//  NewJobRequest.swift
//  GearBear
//
//  Created by Robin Wyffels on 20/05/2025.
//

import Foundation

struct NewJobRequest: Codable {
    let date: Date
    let athleteId: Int
    let skiType: String
    let pairNr: Int
}