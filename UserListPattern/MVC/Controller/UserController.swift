//
//  UserController.swift
//  UserListPattern
//
//  Created by KISHANI on 17/05/24.
//
// UserController.swift

import Foundation
import Combine

class UserController: ObservableObject, UserProtocol {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    
    private let userService = UserService()

    func fetchUsers() {
        userService.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
