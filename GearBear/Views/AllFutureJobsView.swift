//
//  AllFutureJobsView.swift
//  GearBear
//
//  Created by Robin Wyffels on 15/05/2025.
//

import SwiftUI

struct AllFutureJobsView: View {
    let user: User
    @Environment(\.dismiss) private var dismiss
    @StateObject private var todaysJobsViewModel = TodaysJobsViewModel()
    @StateObject private var allFutureJobsViewModel = AllFutureJobsViewModel()
    @State private var selectedJobId: Int? = nil
    
    // Use the view model's jobs for grouping
    var jobsByDate: [String: [Job]] {
        Dictionary(grouping: allFutureJobsViewModel.jobs) { $0.date ?? "Unknown Date" }
    }

    var sortedDates: [String] {
        jobsByDate.keys.sorted()
    }

    var body: some View {
        PageWithNavBar {
            VStack {
                TopBannerView(showBackArrow: true, onBack: { dismiss() })
                ScrollView {
                    // Today's Jobs Section
                    Text("Today's Jobs")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                        .foregroundColor(Color.PrimaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    if todaysJobsViewModel.isLoading {
                        ProgressView("Loading jobs...")
                            .padding()
                    } else if todaysJobsViewModel.jobs.isEmpty {
                        Text("Take a break, there are no jobs for today.")
                            .foregroundColor(Color.PrimaryText)
                            .padding()
                    } else {
                        LazyVStack(spacing: 16) {
                            ForEach(todaysJobsViewModel.jobs) { job in
                                JobCardView(job: job) {
                                    selectedJobId = job.id
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // All Future Jobs Section
                    Text("All Future Jobs")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                        .foregroundColor(Color.PrimaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    if allFutureJobsViewModel.isLoading {
                        ProgressView("Loading all future jobs...")
                            .padding()
                    } else if allFutureJobsViewModel.jobs.isEmpty {
                        Text("No future jobs for now!")
                            .foregroundColor(Color.PrimaryText)
                            .padding()
                    } else {
                        ForEach(sortedDates, id: \.self) { date in
                            Section(header:
                                Text(date)
                                    .font(.headline)
                                    .foregroundColor(Color.PrimaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 10)
                                    .padding(.horizontal)
                            ) {
                                LazyVStack(spacing: 16) {
                                    ForEach(jobsByDate[date] ?? []) { job in
                                        JobCardView(job: job) {
                                            selectedJobId = job.id
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
            .onAppear {
                todaysJobsViewModel.loadJobs(for: user)
                allFutureJobsViewModel.loadJobs(for: user)
            }
            .navigationDestination(item: $selectedJobId) { jobId in
                JobDetailView(jobId: jobId)
            }
        }
    }
}