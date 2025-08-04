//
//  UserCache.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// Model/UserCache.swift
import Foundation

final class UserCache {
    
    private let usersKey = "registered_users"
    private let currentUserKey = "current_logged_in_user"
    
    // MARK: - Registered Users
    func getAllUsers() -> [User] {
        guard let data = UserDefaults.standard.data(forKey: usersKey) else {
            return []
        }
        return (try? JSONDecoder().decode([User].self, from: data)) ?? []
    }
    
    func saveAllUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: usersKey)
        }
    }
    
    func clearAllUsers() {
        UserDefaults.standard.removeObject(forKey: usersKey)
    }
    
    // MARK: - Current Logged In User
//    func getCurrentUser() -> User? {
//        guard let data = UserDefaults.standard.data(forKey: currentUserKey) else {
//            return nil
//        }
//        return try? JSONDecoder().decode(User.self, from: data)
//    }
    
    func getCurrentUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: currentUserKey) else {
            print("DEBUG: No current user data found in UserDefaults")
            return nil
        }
        if let user = try? JSONDecoder().decode(User.self, from: data) {
            print("DEBUG: Current user loaded: \(user)")
            return user
        } else {
            print("DEBUG: Failed to decode current user")
            return nil
        }
    }

    
//    func setCurrentUser(_ user: User) {
//        if let data = try? JSONEncoder().encode(user) {
//            UserDefaults.standard.set(data, forKey: currentUserKey)
//        }
//    }
    func setCurrentUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: currentUserKey)
            print("DEBUG: Current user saved: \(user)")
        } else {
            print("DEBUG: Failed to encode current user")
        }
    }

    
    func clearCurrentUser() {
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }
}
