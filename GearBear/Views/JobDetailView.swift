//
//  JobDetailView.swift
//  GearBear
//
//  Created by Robin Wyffels on 16/05/2025.
//

import SwiftUI

struct JobDetailView: View {
    let jobId: Int
    @StateObject private var viewModel = JobDetailViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading job details...")
            } else if let job = viewModel.job {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Job #\(job.id)")
                            .font(.largeTitle)
                            .bold()
                        Text("Date: \(job.date ?? "Unknown")")
                        Text("Status: \(job.status)")
                        Text("Athlete: \(job.athlete.first?.name ?? "Unknown")")
                        Text("Ski: \(job.ski.type ?? "Unknown") \(job.ski.pairNr ?? 0)")
                        Text("Description: \(job.JobDescription.joined(separator: ", "))")
                        // Add more details as needed
                    }
                    .padding()
                }
            } else {
                Text("Failed to load job details.")
            }
        }
        .onAppear {
            viewModel.loadJob(jobId: jobId)
        }
    }
}