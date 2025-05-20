//
//  ScheduleJobViewModel.swift
//  GearBear
//
//  Created by Robin Wyffels on 19/05/2025.
//

import Foundation
import SwiftUI

class ScheduleJobViewModel: ObservableObject, @unchecked Sendable  {
    @Published var date: Date = Date()
    @Published var athletes: [Athlete] = []
    @Published var selectedAthlete: Athlete? = nil {
        didSet {
            loadSkisForAthlete()
            selectedType = nil
            selectedPairNr = nil
        }
    }
    @Published var skis: [Ski] = []
    @Published var selectedType: String? = nil {
        didSet {
            selectedPairNr = nil
        }
    }
    @Published var selectedPairNr: Int? = nil

    var availableTypes: [String] {
        guard let athlete = selectedAthlete else { return [] }
        let types = skis.filter { $0.athleteId == athlete.id }.compactMap { $0.type }
        return Array(Set(types)).sorted()
    }

    var availablePairNrs: [Int] {
        guard let athlete = selectedAthlete, let type = selectedType else { return [] }
        return skis.filter { $0.athleteId == athlete.id && $0.type == type }
            .compactMap { $0.pairNr }
            .sorted()
    }

    var canSchedule: Bool {
        selectedAthlete != nil && selectedType != nil && selectedPairNr != nil
    }

    func loadAthletes() {
        ScheduleJobService.shared.fetchAthletes { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let athletes):
                    self?.athletes = athletes
                case .failure(let error):
                    print("Failed to load athletes: \(error)")
                }
            }
        }
    }

    func loadSkisForAthlete() {
        guard let athlete = selectedAthlete else {
            skis = []
            return
        }
        ScheduleJobService.shared.fetchSkis(for: athlete.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let skis):
                    self?.skis = skis
                case .failure(let error):
                    print("Failed to load skis: \(error)")
                    self?.skis = []
                }
            }
        }
    }

  
    func scheduleJob(
        status: String,
        jobDescription: [String],
        userId: Int,
        completion: @escaping @Sendable () -> Void
    ) {
        guard let athlete = selectedAthlete,
            let type = selectedType,
            let pairNr = selectedPairNr,
            let ski = skis.first(where: { $0.athleteId == athlete.id && $0.type == type && $0.pairNr == pairNr })
        else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)

        let request = NewJobRequest(
            date: dateString,
            athleteId: athlete.id,
            skiId: ski.id,
            status: status,
            jobDescription: jobDescription,
            userId: userId
        )
        ScheduleJobService.shared.scheduleJob(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion()
                case .failure(let error):
                    print("Failed to schedule job: \(error)")
                }
            }
        }
    }

}
