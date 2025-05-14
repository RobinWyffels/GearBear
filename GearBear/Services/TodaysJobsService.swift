//
//  TodaysJobsService.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import Foundation

class TodaysJobsService: @unchecked Sendable {
    static let shared = TodaysJobsService()
    private let baseUrl = "http://192.168.1.232:8000/todaysJobs" // Replace with your actual API endpoint

    func fetchJobs(for userId: Int, completion: @escaping @Sendable ([Job]?) -> Void) {
        let apiUrl = "\(baseUrl)/\(userId)"
        print("Fetching jobs from URL: \(apiUrl)") // Debugging: Log the URL being fetched
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching jobs: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            // Debugging: Log the raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }

            do {
                let jobs = try JSONDecoder().decode([Job].self, from: data)
                DispatchQueue.main.async {
                    completion(jobs)
                }
            } catch {
                // Debugging: Log decoding errors
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
