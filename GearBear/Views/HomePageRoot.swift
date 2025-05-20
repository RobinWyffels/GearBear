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
    @State private var showQRScanner = false 
    @State private var focussedSki: FocussedSkiResponse? = nil
    @State private var showFocussedSki = false
    @State private var schedulePrefillAthlete: Athlete? = nil
    @State private var schedulePrefillSki: Ski? = nil
    @State private var showQRAlert = false
    @State private var qrAlertMessage = ""

    var body: some View {
        ZStack {
            NavigationStack {
                Group {
                    if let user = selectedUser {
                        HomePageView(
                            user: user,
                            showScheduleJob: $showScheduleJob,
                            selectedJobId: $selectedJobId,
                            showAllFutureJobs: $showAllFutureJobs,
                            onLogout: { selectedUser = nil },
                            qrAction: { showQRScanner = true }
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
                .navigationDestination(item: $selectedJobId) { jobId in
                    JobDetailView(
                        jobId: jobId,
                        showScheduleJob: $showScheduleJob,
                        qrAction: { showQRScanner = true }
                    )
                }
                .navigationDestination(isPresented: $showAllFutureJobs) {
                    if let user = selectedUser {
                        AllFutureJobsView(
                            user: user,
                            showScheduleJob: $showScheduleJob,
                            qrAction: { showQRScanner = true }
                        )
                    }
                }
                .navigationDestination(isPresented: $showScheduleJob) {
                    if let user = selectedUser {
                        ScheduleJobView(
                            user: user,
                            prefillAthlete: $schedulePrefillAthlete,
                            prefillSki: $schedulePrefillSki,
                            qrAction: { showQRScanner = true }
                        )
                    }
                }
                .alert(isPresented: $showQRAlert) {
                    Alert(
                        title: Text("QR Scan Failed"),
                        message: Text(qrAlertMessage),
                        dismissButton: .default(Text("OK")) {
                            showQRScanner = true // Reopen scanner if desired
                        }
                    )
                }
                .navigationDestination(isPresented: $showFocussedSki) {
                    if let skiData = focussedSki {
                        let viewModel = FocussedSkiViewModel(response: skiData)
                        FocussedSkiView(
                            viewModel: viewModel,
                            onScheduleJob: {
                                schedulePrefillAthlete = skiData.athlete
                                schedulePrefillSki = skiData.ski
                                showFocussedSki = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    showScheduleJob = true
                                }
                            }
                        )
                    }
                }
            }
        }
        .sheet(isPresented: $showQRScanner) {
            QRScannerView { scannedCode in
                showQRScanner = false
                SkiService.shared.fetchSkiByQRCode(qrCode: scannedCode) { response in
                    DispatchQueue.main.async {
                        if let response = response {
                            focussedSki = response
                            showFocussedSki = true
                        } else {
                            qrAlertMessage = "QR code not recognised. Try again."
                            showQRAlert = true
                        }
                    }
                }
            }
        }
    }
}