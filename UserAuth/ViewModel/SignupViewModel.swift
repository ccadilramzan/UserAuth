//
//  SignupViewModel.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// ViewModel/SignupViewModel.swift
import Foundation

final class SignupViewModel {
    
    var onSignupSuccess: (() -> Void)?
    var onSignupFailure: ((String) -> Void)?
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func signup(username: String, email: String, password: String) {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            onSignupFailure?("All fields are required.")
            return
        }
        
        // Simple email validation (can be improved)
        guard email.contains("@") else {
            onSignupFailure?("Invalid email address.")
            return
        }
        
        let newUser = User(username: username, email: email, password: password)
        if userService.signup(user: newUser) {
            onSignupSuccess?()
        } else {
            onSignupFailure?("User already exists.")
        }
    }
}

