//
//  ScheduleJobView.swift
//  GearBear
//
//  Created by Robin Wyffels on 19/05/2025.
//


import SwiftUI

struct ScheduleJobView: View {
    let user: User
    @StateObject private var viewModel = ScheduleJobViewModel()
    @Environment(\.dismiss) private var dismiss

    @State private var jobTasks: [JobTask] = []
    @State private var showEditTasksSheet = false
    @State private var showStatusSheet = false
    @State private var selectedStatus: String = "NEEDS PREPPING"

    var body: some View {
        PageWithNavBar {
            VStack {
                TopBannerView(showBackArrow: true, onBack: { dismiss() })
                ScrollView {
                    Text("Schedule Job")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                        .foregroundColor(Color.PrimaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    pickerSection
                    jobDescriptionSection
                    statusSection

                    Button("Schedule Job") {
                        let jobDescriptionStrings = jobTasks.map { "\($0.description)|\($0.status)" }
                        viewModel.scheduleJob(
                            status: selectedStatus,
                            jobDescription: jobDescriptionStrings,
                            userId: user.id
                        ) {
                            DispatchQueue.main.async {
                                dismiss()
                            }
                        }
                    }
                    .disabled(!viewModel.canSchedule)
                    .padding()
                    .background(viewModel.canSchedule ? Color.MainAppColor : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    Spacer()
                }
                .ignoresSafeArea(edges: .top)
                .onAppear {
                    viewModel.loadAthletes()
                }
            }
        }
    }

    private var pickerSection: some View {
        VStack {
            DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding(.horizontal)
                .colorInvert()
                .colorMultiply(.blue)
                .padding(.bottom, 10)

            HStack {
                Text("Athlete")
                Spacer()
                Picker(selection: $viewModel.selectedAthlete) {
                    Text("Select Athlete").tag(Athlete?.none)
                    ForEach(viewModel.athletes, id: \.id) { athlete in
                        Text(athlete.name).tag(Optional(athlete))
                    }
                } label: {
                    Text(viewModel.selectedAthlete?.name ?? "Select Athlete")
                }
                .tint(.blue)
                .background(Color.gray.opacity(0.12))
                .cornerRadius(8)
                .pickerStyle(.menu)
            }
            .padding(.horizontal)

            HStack {
                Text("Type")
                Spacer()
                Picker(selection: $viewModel.selectedType) {
                    Text("Select Type").tag(String?.none)
                    ForEach(viewModel.availableTypes, id: \.self) { type in
                        Text(type).tag(Optional(type))
                    }
                } label: {
                    Text(viewModel.selectedType ?? "Select Type")
                }
                .tint(.blue)
                .background(Color.gray.opacity(0.12))
                .cornerRadius(8)
                .pickerStyle(.menu)
                .disabled(viewModel.selectedAthlete == nil)
            }
            .padding(.horizontal)

            HStack {
                Text("Pair #")
                Spacer()
                Picker(selection: $viewModel.selectedPairNr) {
                    Text("Select Pair Nr").tag(Int?.none)
                    ForEach(viewModel.availablePairNrs, id: \.self) { nr in
                        Text("\(nr)").tag(Optional(nr))
                    }
                } label: {
                    Text(viewModel.selectedPairNr != nil ? "\(viewModel.selectedPairNr!)" : "Select Pair Nr")
                }
                .tint(.blue)
                .background(Color.gray.opacity(0.12))
                .cornerRadius(8)
                .pickerStyle(.menu)
                .disabled(viewModel.selectedType == nil)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.top, 20)
    }

    private var jobDescriptionSection: some View {
        VStack {
            HStack {
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
                        .foregroundColor(Color.MainAppColor)
                }
            }
            .padding(.bottom, 8)

            VStack(alignment: .leading, spacing: 8) {
                if jobTasks.isEmpty {
                    Text("No tasks added yet.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(jobTasks) { task in
                        HStack {
                            Image(systemName: task.status == 1 ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.status == 1 ? Color.MainAppColor : Color.primary)
                            Text(task.description)
                                .foregroundColor(Color.PrimaryText)
                        }
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
        .padding(.top, 20)
        .sheet(isPresented: $showEditTasksSheet) {
            EditJobTasksSheet(
                jobTasks: jobTasks,
                onSave: { updatedTasks in
                    jobTasks = updatedTasks
                    showEditTasksSheet = false
                },
                onCancel: {
                    showEditTasksSheet = false
                }
            )
        }
    }

    private var statusSection: some View {
        VStack {
            Text("Job Status")
                .font(.subheadline)
                .bold()
                .foregroundColor(Color.PrimaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: {
                showStatusSheet = true
            }) {
                Text(selectedStatus)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .padding(2)
                    .frame(maxWidth: .infinity)
                    .background(statusColor(for: selectedStatus))
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
                    selectedStatus = newStatus
                    showStatusSheet = false
                }
            )
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
