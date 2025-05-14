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
    let jobDescription: [JobTask]
    let user: [User]

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case athlete = "Athlete" 
        case ski = "Ski" 
        case status = "Status" 
        case jobDescription = "jobDiscription"
    }
}