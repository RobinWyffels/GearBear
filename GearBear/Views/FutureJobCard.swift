//
//  FutureJobCard.swift
//  GearBear
//
//  Created by Robin Wyffels on 15/05/2025.
//

import SwiftUI

struct FutureJobCard: View {
    let job: FutureJobs

    var body: some View {
        HStack {
            Text("\(job.athlete) - \(job.ski)")
                .font(.subheadline)
                .bold()
                .padding(.vertical, 2)
                .padding(.leading, 8)
                
            Text(job.JobDescription.joined(separator: ", "))
                .font(.subheadline)
                .lineLimit(1)
                .foregroundColor(Color.PrimaryText)
                .padding(.leading, 20)
                .padding(.vertical, 2)
                .padding(.trailing, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(statusColor(for: job.status))
        .cornerRadius(8)
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


// fileprivate extension View {
//     func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//         clipShape(RoundedCorner(radius: radius, corners: corners))
//     }
// }

// fileprivate struct RoundedCorner: Shape {
//     var radius: CGFloat = 12.0
//     var corners: UIRectCorner = .allCorners

//     func path(in rect: CGRect) -> Path {
//         let path = UIBezierPath(
//             roundedRect: rect,
//             byRoundingCorners: corners,
//             cornerRadii: CGSize(width: radius, height: radius)
//         )
//         return Path(path.cgPath)
//     }
// }

//#Preview {
//    FutureJobCard()
//}
