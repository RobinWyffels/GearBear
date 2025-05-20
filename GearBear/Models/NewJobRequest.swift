//
//  NewJobRequest.swift
//  GearBear
//
//  Created by Robin Wyffels on 20/05/2025.
//

import Foundation

struct NewJobRequest: Codable {
    let date: String
    let athleteId: Int
    let skiId: Int
    let status: String
    let jobDescription: [String]
    let userId: Int
}