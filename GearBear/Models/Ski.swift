//
//  Ski.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import Foundation

struct Ski: Identifiable, Decodable {
    let id: Int
    let modelNr: String?
    let type: String?
    let pairNr: Int?
    let brand: String?
    let notes: String?
    let athleteId: Int?
    let length: Int?
    let radius: Int?
    let year: String?
    let firstUse: String?
    let binding: String?
    let frontLift: Int?
    let backLift: Int?
    let frontTotal: Int?
    let backTotal: Int?
    let tipToFrontBinding: Int?
    let qrCodeNr: String?
}