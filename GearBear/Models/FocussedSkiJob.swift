//
//  FocussedSkiJob.swift
//  GearBear
//
//  Created by Robin Wyffels on 20/05/2025.
//

import Foundation

struct FocussedSkiJob: Identifiable, Decodable {
    let id: Int
    let date: String?
    let athleteId: Int
    let skiId: Int
    let status: String
    let jobDescription: [String]
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case athleteId
        case skiId
        case status
        case jobDescription
        case userId
    }
}