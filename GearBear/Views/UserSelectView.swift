//
//  UserSelectView.swift
//  GearBear
//
//  Created by Robin Wyffels on 08/05/2025.
//

import SwiftUI

struct UserSelectView: View {
    @ObservedObject var viewModel = UserSelectViewModel.shared
    var onUserSelected: (User) -> Void

    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.PrimaryText)
                .padding(.bottom, 120)

            if viewModel.users.isEmpty {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 8)

                    Text("No Internet Connection")
                        .font(.headline)
                        .foregroundColor(Color.PrimaryText)
                        .padding()
                }
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                    ForEach(viewModel.users) { user in
                        Button(action: { onUserSelected(user) }) {
                            VStack {
                                Image(user.avatar)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Text(user.name)
                                    .font(.headline)
                                    .foregroundColor(Color.PrimaryText)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.loadUsers()
        }
        .padding()
    }
}
