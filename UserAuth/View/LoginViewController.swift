//
//  LoginViewController.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// View/LoginViewController.swift

import UIKit
//import SwiftUI

final class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    private let loginButton = PrimaryButton(title: "Login")
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
//        viewModel.onLoginSuccess = { [weak self] in
//            self?.showAlert("Success", "Login successful!")
//        }
        viewModel.onLoginSuccess = { [weak self] in
            self?.showAlert("Success", "Login successful!") {
                self?.navigateToMainApp()
            }
        }
        
        viewModel.onLoginFailure = { [weak self] message in
            self?.showAlert("Login Failed", message)
        }
    }
    
    @objc private func loginTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
    }
    
    private func setupUI() {
        view.applyGradientBackground()
        
        titleLabel.text = "Welcome Back 👋"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, emailTextField, passwordTextField, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(signupButton)
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        signupButton.addTarget(self, action: #selector(navigateToSignup), for: .touchUpInside)
    }
    
    private func showAlert(_ title: String, _ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc private func navigateToSignup() {
        let signupVC = SignupViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    private func navigateToMainApp() {
        let mainVC = MainAppViewController()
        if let nav = navigationController {
            nav.setViewControllers([mainVC], animated: true)
        } else {
            present(mainVC, animated: true)
        }
    }
}

#Preview {
    LoginViewController()
}

//extension UIView {
//    func applyGradientBackground() {
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
//        gradient.locations = [0, 1]
//        gradient.frame = bounds
//        layer.insertSublayer(gradient, at: 0)
//    }
//}
