//
//  EditJobTasksSheet.swift
//  GearBear
//
//  Created by Robin Wyffels on 19/05/2025.
//

import SwiftUI

struct EditJobTasksSheet: View {
    @State var jobTasks: [JobTask]
    @State private var newTaskDescription: String = ""
    @State private var editMode: EditMode = .inactive
    @FocusState private var focusedTaskID: UUID?
    @FocusState private var isNewTaskFieldFocused: Bool
    var onSave: ([JobTask]) -> Void
    var onCancel: () -> Void

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(jobTasks) { task in
                        HStack {
                            TextField("Task Description", text: Binding(
                                get: { task.description },
                                set: { newValue in
                                    if let idx = jobTasks.firstIndex(where: { $0.id == task.id }) {
                                        jobTasks[idx].description = newValue
                                    }
                                }
                            ))
                            .focused($focusedTaskID, equals: task.id)
                            .padding(6)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(focusedTaskID == task.id ? Color.accentColor : Color.gray.opacity(0.2), lineWidth: focusedTaskID == task.id ? 2 : 1)
                            )
                            Spacer()
                            Button(action: {
                                if let idx = jobTasks.firstIndex(where: { $0.id == task.id }) {
                                    jobTasks.remove(at: idx)
                                }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(Color.MainAppColor)
                            }
                        }
                    }
                    .onMove { indices, newOffset in
                        jobTasks.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
                .environment(\.editMode, $editMode)
                .padding(.bottom, 70) // Reserve space for the new task bar

                // New Task Bar (always visible, keyboard will cover it if open)
                VStack {
                    HStack {
                        TextField("New Task", text: $newTaskDescription)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .focused($isNewTaskFieldFocused)
                            .submitLabel(.done)
                            .onSubmit {
                                let trimmed = newTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                                if !trimmed.isEmpty {
                                    jobTasks.append(JobTask(description: trimmed, status: 0))
                                    newTaskDescription = ""
                                    isNewTaskFieldFocused = false
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            }
                        Button(action: {
                            let trimmed = newTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !trimmed.isEmpty {
                                jobTasks.append(JobTask(description: trimmed, status: 0))
                                newTaskDescription = ""
                                isNewTaskFieldFocused = false
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color.MainAppColor)
                                .font(.title2)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                }
            }
            .navigationTitle("Edit Tasks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                        .foregroundColor(Color.MainAppColor)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(jobTasks)
                    }
                    .foregroundColor(.blue)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(editMode == .active ? "Done" : "Reorder") {
                        editMode = editMode == .active ? .inactive : .active
                    }
                }
            }
            .accentColor(Color.MainAppColor)
        }
    }
}