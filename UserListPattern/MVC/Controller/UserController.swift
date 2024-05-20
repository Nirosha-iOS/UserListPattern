//
//  UserController.swift
//  UserListPattern
//
//  Created by KISHANI on 17/05/24.
//
// UserController.swift

import Foundation
import Combine
import SwiftUI

class UserController: ObservableObject, UserProtocol {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    
    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUsers() {
        userService.fetchUsers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { users in
                self.users = users
            })
            .store(in: &cancellables)
    }
}

