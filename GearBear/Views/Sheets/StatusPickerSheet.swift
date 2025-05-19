//
//  StatusPickerSheet.swift
//  GearBear
//
//  Created by Robin Wyffels on 19/05/2025.
//

import SwiftUI

struct StatusPickerSheet: View {
    let currentStatus: String
    let onSelect: (String) -> Void

    let statuses = [
        "NEEDS PREPPING",
        "IN PROGRESS",
        "READY",
        "NEEDS SCRAPING",
        "SETUP TUNING"
    ]

    var body: some View {
        NavigationView {
            List(statuses, id: \.self) { status in
                Button(action: { onSelect(status) }) {
                    HStack {
                        Text(status)
                            .foregroundColor(Color.PrimaryText)
                        if status == currentStatus {
                            Spacer()
                            Image(systemName: "checkmark")
                            .foregroundColor(Color.MainAppColor)
                        }
                        
                    }
                }
            }
            .navigationTitle("Set Job Status")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
