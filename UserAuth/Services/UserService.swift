//
//  UserService.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// Services/UserService.swift

import Foundation

protocol UserServiceProtocol {
    func login(email: String, password: String) -> Bool
    func signup(user: User) -> Bool
}

final class UserService: UserServiceProtocol {
    
    private let cache = UserCache()
    
    func login(email: String, password: String) -> Bool {
        guard let user = cache.getUser() else { return false }
        return user.email == email && user.password == password
    }
    
    func signup(user: User) -> Bool {
        guard cache.getUser() == nil else { return false } // Already registered
        cache.saveUser(user)
        return true
    }
}

