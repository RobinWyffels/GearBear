//
//  HomePageView.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import SwiftUI

struct HomePageView: View {
    let user: User
    @StateObject private var viewModel = TodaysJobsViewModel()

    var body: some View {
        VStack 
            if viewModel.isLoading {
                ProgressView("Loading jobs...")
                    .padding()
            } else if viewModel.jobs.isEmpty {
                Text("No jobs found.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.jobs) { job in
                            JobCardView(job: job)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            print("HomePageView loaded for user: \(user.name)")
            viewModel.loadJobs(for: user)
        }
    }
}

#Preview {
    HomePageView(user: User(id: 1, name: "John Doe", avatar: "avatar_placeholder"))
}
