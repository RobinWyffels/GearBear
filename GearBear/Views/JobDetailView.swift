//
//  JobDetailView.swift
//  GearBear
//
//  Created by Robin Wyffels on 16/05/2025.
//

import SwiftUI

struct JobDetailView: View {
    let jobId: Int
    @Binding var showScheduleJob: Bool
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = JobDetailViewModel()
    @State private var showStatusSheet = false
    @State private var showEditTasksSheet = false
    @State private var selectedStatus: String = ""

    var qrAction: () -> Void = {}
    var personAction: () -> Void = {}

    var body: some View {
        PageWithNavBar(
            rightAction: { showScheduleJob = true },
            qrAction: qrAction 
        ) {
            VStack {
                TopBannerView(showBackArrow: true, onBack: { dismiss() }, personAction: personAction)

                if viewModel.isLoading {
                    ProgressView("Loading job details...")
                } else if let job = viewModel.job {
                    ScrollView {
                        HStack {
                            if let brand = job.ski.brand {
                                Image(brand)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 60)
                                Spacer()
                                Text("\(job.athlete.first?.name ?? "Unknown") - \(job.ski.type ?? "Unknown") \(job.ski.pairNr ?? 0)")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color.PrimaryText)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        .padding(.top, 20)
                                
                        VStack{
                            HStack{
                                Text("Job Description")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color.PrimaryText)
                                
                                .frame(maxWidth: .infinity, alignment: .leading)
                                

                                Spacer()
                                Button(action: {
                                    showEditTasksSheet = true
                                }) {
                                    Image(systemName: "square.and.pencil")
                                    .foregroundColor(Color.PrimaryText)
                                }
                            }
                            .padding(.bottom, 8)
                            .sheet(isPresented: $showEditTasksSheet) {
                                EditJobTasksSheet(
                                    jobTasks: viewModel.jobTasks,
                                    onSave: { updatedTasks in
                                        viewModel.jobTasks = updatedTasks
                                        viewModel.uploadTasks()
                                        showEditTasksSheet = false
                                    },
                                    onCancel: {
                                        showEditTasksSheet = false
                                    }
                                )
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(viewModel.jobTasks.indices, id: \.self) { idx in
                                    let task = viewModel.jobTasks[idx]
                                    
                                    HStack {
                                        Image(systemName: task.status == 1 ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(task.status == 1 ? Color.MainAppColor : Color.primaryText)
                                        Text(task.description)
                                            .foregroundColor(Color.PrimaryText)
                                    }
                                    .onTapGesture {
                                        viewModel.toggleTaskStatus(at: idx)
                                    }
                                }
                            }
                            .padding(.leading, 8)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)

                        VStack{
                            Text("Job Status")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color.PrimaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            
                            Button(action: {
                                selectedStatus = job.status
                                showStatusSheet = true
                            }) {
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
                        .padding(.horizontal)
                        .sheet(isPresented: $showStatusSheet) {
                            StatusPickerSheet(
                                currentStatus: selectedStatus,
                                onSelect: { newStatus in
                                    viewModel.updateJobStatus(newStatus)
                                    showStatusSheet = false
                                }
                            )
                        }
                        .onChange(of: showStatusSheet) {
                            if showStatusSheet, let job = viewModel.job {
                                selectedStatus = job.status
                            }
                        }

                        VStack{
                            Text("Ski Notes")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color.PrimaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                

                            Text(job.ski.notes ?? "No notes for this ski")
                                .font(.body)
                                .foregroundColor(Color.PrimaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)

                                
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)

                        VStack{
                            Text("Details")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color.PrimaryText)
                                .padding(.bottom, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                

                            let ski = job.ski 
                            VStack(alignment: .leading, spacing: 16) {
                                SkiDetailRow(title: "Brand", value: ski.brand ?? "-")
                                SkiDetailRow(title: "Type", value: ski.type ?? "-")
                                SkiDetailRow(title: "Numeber", value: ski.pairNr != nil ? "\(ski.pairNr!)" : "-")
                                .padding(.bottom, 8)
                                
                                SkiDetailRow(title: "Length", value: ski.length != nil ? "\(ski.length!) cm" : "- cm")
                                SkiDetailRow(title: "Radius", value: ski.radius != nil ? "\(ski.radius!) m" : "- m")
                                .padding(.bottom, 8)

                                SkiDetailRow(title: "Year", value: ski.year ?? "-")
                                SkiDetailRow(title: "First Use", value: ski.firstUse ?? "-")
                                .padding(.bottom, 8)

                                SkiDetailRow(title: "Model #", value: ski.modelNr ?? "-")
                                SkiDetailRow(title: "Factory Id", value: "\(ski.id)")                                    
                                .padding(.bottom, 8)
                                
                                SkiDetailRow(title: "Binding", value: ski.binding ?? "-")
                                SkiDetailRow(title: "Front Lift", value: ski.frontLift != nil ? "\(ski.frontLift!) mm" : "- mm")
                                SkiDetailRow(title: "Back Lift", value: ski.backLift != nil ? "\(ski.backLift!) mm" : "- mm")
                                SkiDetailRow(title: "Front Total", value: ski.frontTotal != nil ? "\(ski.frontTotal!) mm" : "- mm")
                                SkiDetailRow(title: "Back Total", value: ski.backTotal != nil ? "\(ski.backTotal!) mm" : "- mm")
                                SkiDetailRow(title: "TTFB", value: ski.tipToFrontBinding != nil ? "\(ski.tipToFrontBinding!) mm" : "- mm")
                                .padding(.bottom, 8)
                                
                                SkiDetailRow(title: "QR Code Nr", value: ski.qrCodeNr ?? "-")
                            }
                            .padding(.horizontal)
                            
                            
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)

                    }
                    
                    Spacer()
                    
                } else {
                    Text("Failed to load job details.")
                }
            }
            .ignoresSafeArea(edges: .top)
            .onAppear {
                viewModel.loadJob(jobId: jobId)
            }
        }
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

struct SkiDetailRow: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(title)
                    .font(.body)
                    .bold()
                    .foregroundColor(Color.PrimaryText)
                    .frame(width: 120, alignment: .leading)
                
                Text(value)
                    .font(.body)
                    .foregroundColor(.gray)
                Spacer()
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3))
        }
    }
}
