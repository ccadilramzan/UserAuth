//
//  User.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// Model/User.swift
import Foundation

//struct User: Codable , Identifiable{
//    let id = UUID()
//    let username: String
//    let email: String
//    let password: String
//}

struct User: Codable {
    let username: String
    let email: String
    let password: String
}
