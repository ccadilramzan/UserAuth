//
//  User.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// Model/User.swift
import Foundation

struct User: Codable, Equatable {
    let username: String
    let email: String
    let password: String
}
