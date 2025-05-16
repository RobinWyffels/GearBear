//
//  Job.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import Foundation

struct Job: Identifiable, Decodable {
    let id: Int
    let date: String?
    let athlete: [Athlete]
    let ski: Ski
    let status: String
    let JobDescription: [String]
    let user: [User]?

    enum CodingKeys: String, CodingKey {
        case id
        case date = "Date" 
        case athlete = "Athlete"
        case ski = "Ski"
        case status = "Status"
        case jobDescription = "JobDiscription"
        case user = "User"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try container.decode(Int.self, forKey: .id)
            date = try container.decodeIfPresent(String.self, forKey: .date)
            athlete = try container.decode([Athlete].self, forKey: .athlete)
            ski = try container.decode(Ski.self, forKey: .ski)
            status = try container.decode(String.self, forKey: .status)
            JobDescription = try container.decode([String].self, forKey: .jobDescription)
            user = try container.decodeIfPresent([User].self, forKey: .user)
        } catch {
            print("Error decoding Job: \(error)")
            throw error
        }
    }
}
