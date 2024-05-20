//
//  UserService.swift
//  UserListPattern
//
//  Created by KISHANI on 17/05/24.
//


import Foundation
import Combine
import Foundation
import Combine

class UserService {
    func fetchUsers() -> AnyPublisher<[User], Error> {
        let url = URL(string: "https://gorest.co.in/public/v2/users")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


