//
//  ScheduleJobView.swift
//  GearBear
//
//  Created by Robin Wyffels on 19/05/2025.
//

import SwiftUI

struct ScheduleJobView: View {
    @StateObject private var viewModel = ScheduleJobViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding(.horizontal)

                Picker("Athlete", selection: $viewModel.selectedAthlete) {
                    Text("Select Athlete").tag(Athlete?.none)
                    ForEach(viewModel.athletes, id: \.id) { athlete in
                        Text(athlete.name).tag(Optional(athlete))
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)

                Picker("Ski Type", selection: $viewModel.selectedType) {
                    Text("Select Type").tag(String?.none)
                    ForEach(viewModel.availableTypes, id: \.self) { type in
                        Text(type).tag(Optional(type))
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                .disabled(viewModel.selectedAthlete == nil)

                Picker("Pair Nr", selection: $viewModel.selectedPairNr) {
                    Text("Select Pair Nr").tag(Int?.none)
                    ForEach(viewModel.availablePairNrs, id: \.self) { nr in
                        Text("\(nr)").tag(Optional(nr))
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                .disabled(viewModel.selectedType == nil)

                Button("Schedule Job") {
                    viewModel.scheduleJob {
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
            .navigationTitle("Schedule Job")
            .onAppear {
                viewModel.loadAthletes()
            }
        }
    }
}