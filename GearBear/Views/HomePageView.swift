//
//  HomePageView.swift
//  GearBear
//
//  Created by Robin Wyffels on 13/05/2025.
//

import SwiftUI

struct HomePageView: View {
    let user: User
    @Binding var showScheduleJob: Bool
    @Binding var selectedJobId: Int?
    @Binding var showAllFutureJobs: Bool
    var personAction: () -> Void = {}
    var qrAction: () -> Void = {}

    @StateObject private var viewModel = TodaysJobsViewModel()
    @StateObject private var futureJobsViewModel = FutureJobsViewModel()

    var body: some View {
        PageWithNavBar(
            rightAction: { showScheduleJob = true },
            qrAction: qrAction 
        ) {
            VStack {
                TopBannerView(showBackArrow: false, onBack: nil, personAction: personAction )
                ScrollView {
                    // Today's Jobs Section
                    Text("Today's Jobs")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                        .foregroundColor(Color.PrimaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    if viewModel.isLoading {
                        ProgressView("Loading jobs...")
                            .padding()
                    } else if viewModel.jobs.isEmpty {
                        Text("Take a break, there are no jobs for today.")
                            .foregroundColor(Color.PrimaryText)
                            .padding()
                    } else {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.jobs) { job in
                                JobCardView(job: job) {
                                    selectedJobId = job.id
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    // Future Jobs Section
                    Text("Future Jobs")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                        .foregroundColor(Color.PrimaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    if futureJobsViewModel.isLoading {
                        ProgressView("Loading future jobs...")
                            .padding()
                    } else if futureJobsViewModel.jobs.isEmpty {
                        Text("No future jobs for now!")
                            .foregroundColor(Color.PrimaryText)
                            .padding()
                    } else {
                        Button(action: { showAllFutureJobs = true }) {
                            LazyVStack {
                                ForEach(futureJobsViewModel.jobs) { job in
                                    FutureJobCard(job: job)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
            .onAppear {
                print("HomePageView loaded for user: \(user.name)")
                viewModel.loadJobs(for: user)
                futureJobsViewModel.loadJobs(for: user)
            }
        }
    }
}
