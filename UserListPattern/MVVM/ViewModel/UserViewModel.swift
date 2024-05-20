//
//  UserViewModel.swift
//  UserListPattern
//
//  Created by KISHANI on 18/05/24.
//

// UserViewModel.swift
import Foundation
import Combine

import Foundation
import Combine

class UserViewModel: ObservableObject, UserProtocol {
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

