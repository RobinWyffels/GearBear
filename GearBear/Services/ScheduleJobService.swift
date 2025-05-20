//
//  ScheduleJobService.swift
//  GearBear
//
//  Created by Robin Wyffels on 19/05/2025.
//

import Foundation

class ScheduleJobService: @unchecked Sendable { 
    static let shared = ScheduleJobService()
    private let baseURL = URL(string: "http://192.168.1.170:8000")!

    private init() {}

    func fetchAthletes(completion: @escaping @Sendable(Result<[Athlete], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/athletes")
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            do {
                let athletes = try JSONDecoder().decode([Athlete].self, from: data)
                completion(.success(athletes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchSkis(for athleteId: Int, completion: @escaping @Sendable(Result<[Ski], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/athletes/\(athleteId)/skis")
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            do {
                let skis = try JSONDecoder().decode([Ski].self, from: data)
                completion(.success(skis))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func scheduleJob(request: NewJobRequest, completion: @escaping @Sendable (Result<Void, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/jobs")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            completion(.failure(error))
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }.resume()
    }
}
