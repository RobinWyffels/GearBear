//
//  HomePageView.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import SwiftUI

struct HomePageView: View {
    let user: User // Accept the selected user as a parameter
    @StateObject private var viewModel = TodaysJobsViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome, \(user.name)!")
                    .font(.largeTitle)
                    .padding()

                if viewModel.isLoading {
                    ProgressView("Loading jobs...")
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
                viewModel.loadJobs(for: user) // Load jobs for the selected user
            }
        }
    }
}

#Preview {
    HomePageView(user: User(id: 1, name: "John Doe", avatar: "avatar_placeholder"))
}
