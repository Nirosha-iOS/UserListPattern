//
//  UserViewModel.swift
//  UserListPattern
//
//  Created by KISHANI on 18/05/24.
//

// UserViewModel.swift
import Foundation
import Combine

class UserViewModel: ObservableObject, UserProtocol {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    
    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()

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


