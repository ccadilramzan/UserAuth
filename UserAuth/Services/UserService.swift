//
//  UserService.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//
//
//// Services/UserService.swift
//
//import Foundation
//
//protocol UserServiceProtocol {
//    func login(email: String, password: String) -> Bool
//    func signup(user: User) -> Bool
//}
//
//final class UserService: UserServiceProtocol {
//    
//    private let cache = UserCache()
//    
//    func login(email: String, password: String) -> Bool {
//        guard let user = cache.getUser() else { return false }
//        return user.email == email && user.password == password
//    }
//    
//    func signup(user: User) -> Bool {
//        guard cache.getUser() == nil else { return false } // Already registered
//        cache.saveUser(user)
//        return true
//    }
//}

import Foundation

// MARK: - Protocol
protocol UserServiceProtocol {
    func login(email: String, password: String) -> Bool
    func signup(user: User) -> Bool
}

final class UserService: UserServiceProtocol {
    
    private let cache = UserCache()
    
    func login(email: String, password: String) -> Bool {
        let allUsers = cache.getAllUsers()
        print("DEBUG: Stored Users -> \(allUsers)")
        
        guard let user = allUsers.first(where: {
            $0.email.lowercased() == email.lowercased() && $0.password == password
        }) else {
            print("DEBUG: No matching user found for email=\(email)")
            return false
        }
        
        print("DEBUG: Login success for user: \(user)")
        cache.setCurrentUser(user)
        return true
    }

    func signup(user: User) -> Bool {
        var users = cache.getAllUsers()
        guard !users.contains(where: { $0.email.lowercased() == user.email.lowercased() }) else {
            return false
        }
        users.append(user)
        cache.saveAllUsers(users)
        cache.setCurrentUser(user) // saves current logged-in user
        return true
    }
}
