//
//  SignupViewController.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

import SwiftUI

// View/SignupViewController.swift
import UIKit

final class SignupViewController: UIViewController {
    
    private let viewModel = SignupViewModel()
    
    private let usernameTextField = CustomTextField(placeholder: "Username")
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    private let signupButton = PrimaryButton(title: "Sign Up")
    private let titleLabel = UILabel()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        bindViewModel()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        navigationController?.navigationBar.prefersLargeTitles = true
        // other UI setup...
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.onSignupSuccess = { [weak self] in
            self?.showAlert("Success", "Account created successfully! Please login.") {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        viewModel.onSignupFailure = { [weak self] message in
            self?.showAlert("Signup Failed", message)
        }
    }
    
    @objc private func signupTapped() {
        let username = usernameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.signup(username: username, email: email, password: password)
    }
    
    private func setupUI() {
        view.applyGradientBackground()
        
        titleLabel.text = "Create Account"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, usernameTextField, emailTextField, passwordTextField, signupButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showAlert(_ title: String, _ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default) { _ in completion?() })
        present(alert, animated: true)
    }
}


#Preview {
    SignupViewController()
}
