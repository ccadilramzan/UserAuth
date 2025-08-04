//
//  MainAppViewController.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

import UIKit

final class MainAppViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the Main App!"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            logoutButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
//    @objc private func logoutTapped() {
//        // Clear cached user data
//        UserCache().clearUser()
//        
//        // Navigate back to Login screen
//        let loginVC = LoginViewController()
//        let navVC = UINavigationController(rootViewController: loginVC)
//        
//        // Replace the window's rootViewController to reset the flow
//        if let windowScene = view.window?.windowScene,
//           let delegate = windowScene.delegate as? SceneDelegate,
//           let window = delegate.window {
//            window.rootViewController = navVC
//            UIView.transition(with: window,
//                              duration: 0.5,
//                              options: .transitionFlipFromLeft,
//                              animations: nil)
//        }
//    }
    
//    @objc func logoutTapped() {
//        UserCache().clearCurrentUser()
//        let loginVC = LoginViewController()
//        let navVC = UINavigationController(rootViewController: loginVC)
//        UIApplication.shared.windows.first?.rootViewController = navVC
//
//    }
    
    @objc func logoutTapped() {
        UserCache().clearCurrentUser()
        let loginVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: loginVC)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navVC
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: nil)
        }
    }


//    @objc private func logoutTapped() {
//        // Clear cached user data
//        UserCache().clearUser()
//        
//        // Create login screen nav controller
//        let loginVC = LoginViewController()
//        let navVC = UINavigationController(rootViewController: loginVC)
//        
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let window = windowScene.windows.first {
//            window.rootViewController = navVC
//            UIView.transition(with: window,
//                              duration: 0.5,
//                              options: .transitionFlipFromLeft,
//                              animations: nil)
//        }
//    }

}


#Preview {
    MainAppViewController()
}
