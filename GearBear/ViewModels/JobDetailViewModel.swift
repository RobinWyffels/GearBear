//
//  JobDetailViewModel.swift
//  GearBear
//
//  Created by Robin Wyffels on 16/05/2025.
//

import Foundation
import SwiftUI

class JobDetailViewModel: ObservableObject, @unchecked Sendable {
    @Published var job: Job?
    @Published var isLoading: Bool = false

    func loadJob(jobId: Int) {
        isLoading = true
        JobDetailService.shared.fetchJob(jobId: jobId) { [weak self] job in
            guard let self = self else { return }
            self.job = job
            self.isLoading = false
        }
    }
}
