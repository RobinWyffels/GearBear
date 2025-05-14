//
//  JobTask.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import Foundation

struct JobTask: Decodable {
    let description: String
    let status: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        let components = rawValue.split(separator: "|")
        self.description = String(components[0])
        self.status = Int(components[1]) ?? 0
    }
}