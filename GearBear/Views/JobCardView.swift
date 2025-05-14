//
//  JobCardView.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import SwiftUI

struct JobCardView: View {
    let job: Job

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(job.athlete.first?.name ?? "Unknown") - \(job.ski.first?.type ?? "Unknown") \(job.ski.first?.pairNr ?? 0)")
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color.primaryText)
                Spacer()
                Text(job.status)
                    .font(.subheadline)
                    .foregroundColor(Color.primaryText)
                    .padding(8)
                    .background(statusColor(for: job.status))
                    .cornerRadius(8)
            }

            Text(job.jobDescription.map { $0.description }.joined(separator: ", "))
                .font(.subheadline)
                .lineLimit(1)
                .foregroundColor(.gray)

            Button(action: {}) {
                Text(job.status)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(statusColor(for: job.status))
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    private func statusColor(for status: String) -> Color {
        switch status {
        case "NEEDS PREPPING":
            return Color.StatusNeedsPrep
        case "IN PROGRESS":
            return Color.StatusInProgress
        case "READY":
            return Color.StatusReady
        case "NEEDS SCRAPING":
            return Color.StatusNeedsScraping
        case "SETUP TUNING":
            return Color.StatusSetupTuning
        default:
            return Color.gray
        }
    }
}


