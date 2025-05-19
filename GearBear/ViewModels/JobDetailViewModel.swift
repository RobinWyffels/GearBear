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
    @Published var jobTasks: [JobTask] = []


   func loadJob(jobId: Int) {
        isLoading = true
        JobDetailService.shared.fetchJob(jobId: jobId) { [weak self] job in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.job = job
                
                if let job = job {
                    self.jobTasks = job.JobDescription.map { desc in
                        let parts = desc.split(separator: "|", omittingEmptySubsequences: false)
                        let description = parts.first.map(String.init) ?? ""
                        let status = parts.count > 1 ? Int(parts[1]) ?? 0 : 0
                        return JobTask(description: description, status: status)
                    }
                } else {
                    self.jobTasks = []
                }
                self.isLoading = false
            }
        }
    }

    func toggleTaskStatus(at index: Int) {
        guard jobTasks.indices.contains(index) else { return }
        jobTasks[index].status = jobTasks[index].status == 1 ? 0 : 1
        uploadTasks()
    }

    func uploadTasks() {
        guard let jobId = job?.id else { return }
        
        let updatedDescriptions = jobTasks.map { "\($0.description)|\($0.status)" }
        JobDetailService.shared.updateJobTasks(jobId: jobId, jobDescriptions: updatedDescriptions) { success in
            
        }
    }

    func updateJobStatus(_ newStatus: String) {
    guard let jobId = job?.id else { return }
    JobDetailService.shared.updateJobStatus(jobId: jobId, status: newStatus) { [weak self] success in
        DispatchQueue.main.async {
            if success {
                self?.job?.status = newStatus
            }
        }
    }
}

    

    
}
