//
//  AllFutureJobsService.swift
//  GearBear
//
//  Created by Robin Wyffels on 15/05/2025.
//

import Foundation

class AllFutureJobsService: @unchecked Sendable {
    static let shared = AllFutureJobsService()
    private let baseUrl = "http://192.168.1.170:8000/allFutureJobs"

    func fetchJobs(for userId: Int, completion: @escaping @Sendable ([Job]?) -> Void) {
        let apiUrl = "\(baseUrl)/\(userId)"
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching all future jobs: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            do {
                let jobs = try JSONDecoder().decode([Job].self, from: data)
                DispatchQueue.main.async {
                    completion(jobs)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
