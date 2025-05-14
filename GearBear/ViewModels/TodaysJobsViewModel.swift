//
//  TodaysJobsViewModel.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import Foundation
import SwiftUI

class TodaysJobsViewModel: ObservableObject, @unchecked Sendable { 
    @Published var jobs: [Job] = []
    @Published var isLoading: Bool = false

    func loadJobs(for user: User) {
        isLoading = true
        let userId = user.id 
        
        TodaysJobsService.shared.fetchJobs(for: userId) { [weak self] fetchedJobs in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                if let fetchedJobs = fetchedJobs {
                    self.jobs = fetchedJobs
                } else {
                    print("Failed to fetch jobs")
                }
            }
        }
    }
}
