//
//  UserProtocol.swift
//  UserListPattern
//
//  Created by KISHANI on 18/05/24.
//

import Foundation
import Combine

protocol UserProtocol: ObservableObject {
    var users: [User] { get }
    var errorMessage: String? { get }
    func fetchUsers()
}
