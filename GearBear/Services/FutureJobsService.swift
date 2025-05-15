//
//  FutureJobsService.swift
//  GearBear
//
//  Created by Robin Wyffels on 15/05/2025.
//

import Foundation

class FutureJobsService: @unchecked Sendable {
    static let shared = FutureJobsService()
    private let baseUrl = "http://192.168.1.170:8000/futureJobs" // Replace with your actual API endpoint
    
    func fetchJobs(for userId: Int, completion: @escaping @Sendable ([FutureJobs]?) -> Void) {
        let apiUrl = "\(baseUrl)/\(userId)"
        print("Fetching jobs from URL: \(apiUrl)")
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching futureJobs: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }
            
           do {
                let futureJobs = try JSONDecoder().decode([FutureJobs].self, from: data)
                DispatchQueue.main.async {
                    completion(futureJobs)
                }
            } catch {
                // Debugging: Log decoding errors
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
