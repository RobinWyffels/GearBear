//
//  FutureJobsViewModel.swift
//  GearBear
//
//  Created by Robin Wyffels on 15/05/2025.
//

import Foundation
import SwiftUI

class FutureJobsViewModel: ObservableObject, @unchecked Sendable {
    @Published var jobs: [FutureJobs] = []
    @Published var isLoading: Bool = false

    func loadJobs(for user: User) {
        isLoading = true
        let userId = user.id

        FutureJobsService.shared.fetchJobs(for: userId) { [weak self] fetchedJobs in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                if let fetchedJobs = fetchedJobs {
                    self.jobs = fetchedJobs
                }
            }
        }
    }
}
