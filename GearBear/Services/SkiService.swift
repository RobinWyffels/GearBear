//
//  SkiService.swift
//  GearBear
//
//  Created by Robin Wyffels on 20/05/2025.
//

import Foundation

class SkiService: @unchecked Sendable {
    static let shared = SkiService()
    private let baseUrl = "http://192.168.1.170:8000/skis"

    func fetchSkiByQRCode(qrCode: String, completion: @escaping @Sendable (FocussedSkiResponse?) -> Void) {
        let urlString = "\(baseUrl)/qr/\(qrCode)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching ski by QR: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let response = try JSONDecoder().decode(FocussedSkiResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error decoding FocussedSkiResponse: \(error)")
                completion(nil)
            }
        }.resume()
    }
}