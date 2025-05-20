//
//  HomePageRoot.swift
//  GearBear
//
//  Created by Robin Wyffels on 20/05/2025.
//

import SwiftUI

struct HomePageRoot: View {
    @Binding var selectedUser: User?
    @State private var showScheduleJob = false
    @State private var selectedJobId: Int? = nil
    @State private var showAllFutureJobs = false

    var body: some View {
        NavigationStack {
            Group {
                if let user = selectedUser {
                    HomePageView(
                        user: user,
                        showScheduleJob: $showScheduleJob,
                        selectedJobId: $selectedJobId,
                        showAllFutureJobs: $showAllFutureJobs,
                        onLogout: { selectedUser = nil }
                    )
                } else {
                    Color.clear
                }
            }
            .fullScreenCover(isPresented: Binding(
                get: { selectedUser == nil },
                set: { _ in }
            )) {
                UserSelectView { user in
                    selectedUser = user
                }
            }
            .navigationDestination(isPresented: $showScheduleJob) {
                if let user = selectedUser {
                    ScheduleJobView(user: user)
                }
            }
            .navigationDestination(item: $selectedJobId) { jobId in
                JobDetailView(jobId: jobId, showScheduleJob: $showScheduleJob)
            }
            .navigationDestination(isPresented: $showAllFutureJobs) {
                if let user = selectedUser {
                    AllFutureJobsView(user: user, showScheduleJob: $showScheduleJob)
                }
            }
        }
    }
}
