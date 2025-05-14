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
                Text("\(job.athlete.first?.name ?? "Unknown") - \(job.ski.type ?? "Unknown") \(job.ski.pairNr ?? 0)")
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color.primaryText)
                    .padding(.bottom, 10)
                Spacer()

                Text(job.JobDescription.joined(separator: ", "))
                .font(.subheadline)
                .lineLimit(1)
                .foregroundColor(Color.primaryText)
                
            }
            Button(action: {}) {
                Text(job.status)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .padding(2)
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
