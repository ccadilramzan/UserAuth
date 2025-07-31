//
//  LoginViewModel.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// ViewModel/LoginViewModel.swift

//import Foundation
//
//final class LoginViewModel {
//    
//    var onLoginSuccess: (() -> Void)?
//    var onLoginFailure: ((String) -> Void)?
//    
//    private let userService: UserServiceProtocol
//    
//    init(userService: UserServiceProtocol = UserService()) {
//        self.userService = userService
//    }
//    
//    func login(email: String, password: String) {
//        guard !email.isEmpty, !password.isEmpty else {
//            onLoginFailure?("Email and password must not be empty.")
//            return
//        }
//        
//        if userService.login(email: email, password: password) {
//            onLoginSuccess?()
//        } else {
//            onLoginFailure?("Invalid credentials.")
//        }
//    }
//}

import Foundation

final class LoginViewModel {
    
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            onLoginFailure?("Email and password must not be empty.")
            return
        }
        
        if userService.login(email: email, password: password) {
            onLoginSuccess?()
        } else {
            onLoginFailure?("Invalid credentials.")
        }
    }
}
