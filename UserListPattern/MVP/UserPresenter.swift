//
//  UserPresenter.swift
//  UserListPattern
//
//  Created by KISHANI on 18/05/24.
//

// UserPresenter.swift
import Foundation
import Combine

protocol UserView: AnyObject {
    func displayUsers(_ users: [User])
    func displayError(_ error: String)
}

class UserPresenter: ObservableObject, UserProtocol {
    
    
    @Published var users: [User] = []
    @Published var errorMessage: String?
    
    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()
    weak var view: UserView?

    func attachView(_ view: UserView) {
        self.view = view
    }

    func fetchUsers() {
    }
}
