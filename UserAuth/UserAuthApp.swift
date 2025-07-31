
//
//  UserAuthApp.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

import SwiftUI
import UIKit

struct LoginViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        return navController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Nothing needed here
    }
}

@main
struct UserAuthApp: App {
    var body: some Scene {
        WindowGroup {
            LoginViewControllerWrapper()
        }
    }
}


