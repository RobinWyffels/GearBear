//
//  UserSelectViewModel.swift
//  GearBear
//
//  Created by Robin Wyffels on 08/05/2025.
//
import Foundation
import SwiftUI
import Combine

class UserSelectViewModel: ObservableObject, @unchecked Sendable {
    @Published var users: [User] = []
    @Published var selectedUser: User? = nil
    
    func loadUsers() {
        UserService.shared.fetchUsers { [weak self] fetchedUsers in
            guard let self = self else { return }
            if let fetchedUsers = fetchedUsers {
                DispatchQueue.main.async {
                    self.users = fetchedUsers
                }
            }
        }
    }
}
