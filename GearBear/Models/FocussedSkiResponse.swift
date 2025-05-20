//
//  FocussedSkiResponse.swift
//  GearBear
//
//  Created by Robin Wyffels on 20/05/2025.
//

import Foundation

struct FocussedSkiResponse: Decodable {
    let ski: Ski
    let athlete: Athlete
    let jobs: [FocussedSkiJob]
}
