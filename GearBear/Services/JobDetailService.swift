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

    func updateJobTasks(jobId: Int, jobDescriptions: [String], completion: @escaping @Sendable (Bool) -> Void) {
        let apiUrl = "\(baseUrl)/\(jobId)/tasks"
        guard let url = URL(string: apiUrl) else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["JobDiscription": jobDescriptions]
        if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("PUT body for job update:\n\(jsonString)")
        }
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating tasks: \(error)")
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
    
    func updateJobStatus(jobId: Int, status: String, completion: @escaping @Sendable (Bool) -> Void) {
        let apiUrl = "\(baseUrl)/\(jobId)/status"
        guard let url = URL(string: apiUrl) else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["Status": status]
        if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted),
        let jsonString = String(data: jsonData, encoding: .utf8) {
            print("PUT body for status update:\n\(jsonString)")
        }
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating status: \(error)")
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }

}
