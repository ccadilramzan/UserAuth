//
//  UserCache.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// Model/UserCache.swift

//import Foundation
//
//final class UserCache {
//    
//    private let userKey = "savedUser"
//    private let defaults = UserDefaults.standard
//    
//    func saveUser(_ user: User) {
//        if let data = try? JSONEncoder().encode(user) {
//            defaults.set(data, forKey: userKey)
//        }
//    }
//    
//    func getUser() -> User? {
//        guard let data = defaults.data(forKey: userKey) else { return nil }
//        return try? JSONDecoder().decode(User.self, from: data)
//    }
//    
//    func clearUser() {
//        defaults.removeObject(forKey: userKey)
//    }
//}

import Foundation
final class UserCache {
    
    private let userKey = "loggedInUser"
    
    func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }
    
    func getUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }
    
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}
