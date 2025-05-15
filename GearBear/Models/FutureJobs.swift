//
//  FutureJobs.swift
//  GearBear
//
//  Created by Robin Wyffels on 15/05/2025.
//

import Foundation

struct FutureJobs: Identifiable, Decodable {
    let id: Int
    let athlete: String
    let status: String
    let ski: String
    let JobDescription: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case athlete = "Athlete"
        case status = "Status"
        case ski = "Ski"
        case jobDescription = "JobDiscription"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        athlete = try container.decode(String.self, forKey: .athlete)
        status = try container.decode(String.self, forKey: .status)
        ski = try container.decode(String.self, forKey: .ski)
        JobDescription = try container.decode([String].self, forKey: .jobDescription)
    }
}

