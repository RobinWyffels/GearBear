//
//  UserSelectView.swift
//  GearBear
//
//  Created by Robin Wyffels on 08/05/2025.
//

import SwiftUI

struct UserSelectView: View {
    @ObservedObject var viewModel = UserSelectViewModel.shared
    @State private var navigateToHomePage = false 
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.primaryText)
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
                            .foregroundColor(Color.primaryText)
                            .padding()
                    }
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        ForEach(viewModel.users) { user in
                            NavigationLink(value: user) { 
                                VStack {
                                    Image(user.avatar)
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    Text(user.name)
                                        .font(.headline)
                                        .foregroundColor(Color.primaryText)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color("PrimaryTextLight"), radius: 15, x: 0, y: 0)
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.loadUsers()
            }
            .padding()
            .navigationDestination(for: User.self) { user in
                HomePageView(user: user) 
            }
        }
    }
}
