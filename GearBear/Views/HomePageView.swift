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
        PageWithNavBar {
            VStack {
                TopBannerView(showBackArrow: false, onBack: nil)

                if viewModel.isLoading {
                    Text("Today's Jobs")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                        .foregroundColor(Color.PrimaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ProgressView("Loading jobs...")
                        .padding()
                } else if viewModel.jobs.isEmpty {
                    Text("Today's Jobs")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                        .foregroundColor(Color.PrimaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Text("Take a break, there are no jobs for today.")
                        .foregroundColor(Color.PrimaryText)
                        .padding()
                } else {
                    ScrollView {
                        Text("Today's Jobs")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                        .foregroundColor(Color.PrimaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.jobs) { job in
                                JobCardView(job: job)
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
            .onAppear {
                print("HomePageView loaded for user: \(user.name)")
                viewModel.loadJobs(for: user)
            }
        }
    }
}

//#Preview {
//    HomePageView(user: User(id: 1, name: "John Doe", avatar: "avatar_placeholder"))
//}
