//
//  User.swift
//  UserListPattern
//
//  Created by KISHANI on 17/05/24.
//
import Foundation


struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let gender: String
    let status: String
}
