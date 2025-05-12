//
//  UserSelectView.swift
//  GearBear
//
//  Created by Robin Wyffels on 08/05/2025.
//

import SwiftUI

struct UserSelectView: View {
    @ObservedObject var viewModel = UserSelectViewModel()
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 120)
            
            if viewModel.users.isEmpty {
                Text("Loading users...")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                    ForEach(viewModel.users) { user in
                        Button(action: {
                            viewModel.selectedUser = user
                        }) {
                            VStack {
                                Image(user.avatar)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Text(user.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
            
            if let selectedUser = viewModel.selectedUser {
                Text("Selected: \(selectedUser.name)")
                    .font(.title2)
                    .padding(.top, 20)
            }
        }
        .onAppear {
            viewModel.loadUsers()
        }
        .padding()
    }
}



