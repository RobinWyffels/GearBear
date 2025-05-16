//
//  JobDetailService.swift
//  GearBear
//
//  Created by Robin Wyffels on 16/05/2025.
//

import Foundation

class JobDetailService: @unchecked Sendable {
    static let shared = JobDetailService()
    private let baseUrl = "http://192.168.1.170:8000/job"

    func fetchJob(jobId: Int, completion: @escaping @Sendable (Job?) -> Void) {
        let apiUrl = "\(baseUrl)/\(jobId)"
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching job: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            do {
                let job = try JSONDecoder().decode(Job.self, from: data)
                DispatchQueue.main.async {
                    completion(job)
                }
            } catch {
                print("Error decoding Job: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
