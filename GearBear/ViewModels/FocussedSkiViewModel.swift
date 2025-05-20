//
//  FocussedSkiViewModel.swift
//  GearBear
//
//  Created by Robin Wyffels on 20/05/2025.
//

import Foundation
import SwiftUI

class FocussedSkiViewModel: ObservableObject {
    @Published var ski: Ski
    @Published var athlete: Athlete
    @Published var jobs: [FocussedSkiJob]

    init(response: FocussedSkiResponse) {
        self.ski = response.ski
        self.athlete = response.athlete
        self.jobs = response.jobs
    }
    
    var jobCards: [Job] {
        jobs.map { job in
            Job(
                id: job.id,
                date: job.date,
                athlete: [athlete],
                ski: ski,
                status: job.status,
                JobDescription: job.jobDescription,
                user: nil
            )
        }
    }
}
