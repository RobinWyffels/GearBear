//
//  UserService.swift
//  GearBear
//
//  Created by Robin Wyffels on 12/05/2025.
//

import Foundation

class UserService: @unchecked Sendable {
    static let shared = UserService()
    private let apiUrl = "http://192.168.1.170:8000/users"

    func fetchUsers(completion: @escaping @Sendable ([User]?) -> Void) {
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching users: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    completion(users)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
