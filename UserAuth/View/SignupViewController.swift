//
//  SignupViewController.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

//import SwiftUI
//// View/SignupViewController.swift
//import UIKit
//
//final class SignupViewController: UIViewController {
//    
//    private let viewModel = SignupViewModel()
//    
//    private let usernameTextField = CustomTextField(placeholder: "Username")
//    private let emailTextField = CustomTextField(placeholder: "Email")
//    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
//    private let signupButton = PrimaryButton(title: "Sign Up")
//    private let titleLabel = UILabel()
//    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        setupUI()
////        bindViewModel()
////    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Sign Up"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        // other UI setup...
//        setupUI()
//        bindViewModel()
//    }
//    
//    private func bindViewModel() {
//        viewModel.onSignupSuccess = { [weak self] in
//            self?.showAlert("Success", "Account created successfully! Please login.") {
//                self?.navigationController?.popViewController(animated: true)
//            }
//        }
//        
//        viewModel.onSignupFailure = { [weak self] message in
//            self?.showAlert("Signup Failed", message)
//        }
//    }
//    
//    @objc private func signupTapped() {
//        let username = usernameTextField.text ?? ""
//        let email = emailTextField.text ?? ""
//        let password = passwordTextField.text ?? ""
//        viewModel.signup(username: username, email: email, password: password)
//    }
//    
//    private func setupUI() {
//        view.applyGradientBackground()
//        
//        titleLabel.text = "Create Account"
//        titleLabel.font = .boldSystemFont(ofSize: 28)
//        titleLabel.textAlignment = .center
//        titleLabel.textColor = .white
//        
//        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
//        
//        let stack = UIStackView(arrangedSubviews: [titleLabel, usernameTextField, emailTextField, passwordTextField, signupButton])
//        stack.axis = .vertical
//        stack.spacing = 20
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(stack)
//        
//        NSLayoutConstraint.activate([
//            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
//            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
//            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
//    private func showAlert(_ title: String, _ message: String, completion: (() -> Void)? = nil) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(.init(title: "OK", style: .default) { _ in completion?() })
//        present(alert, animated: true)
//    }
//}
//
//
//#Preview {
//    SignupViewController()
//}

import UIKit

final class SignupViewController: UIViewController {
    
    private let viewModel = SignupViewModel()
    
//    private let usernameTextField = CustomTextField(placeholder: "Username")
//    private let emailTextField = CustomTextField(placeholder: "Email")
//    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    
    private lazy var usernameTextField = createCustomTextField(placeholder: "Username")
    private lazy var emailTextField = createCustomTextField(placeholder: "Email")
    private lazy var passwordTextField = createCustomTextField(placeholder: "Password", isSecure: true)

    private let signupButton = PrimaryButton(title: "Sign Up")
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
        bindViewModel()
        configureTextFields()
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
    
    // MARK: - Configure TextFields
    private func configureTextFields() {
        usernameTextField.keyboardType = .asciiCapable
        usernameTextField.autocapitalizationType = .words
        usernameTextField.autocorrectionType = .no
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textContentType = .emailAddress
        
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.textContentType = .newPassword
        
        // Add Eye Icon with Padding
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        eyeButton.tintColor = .gray
        eyeButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        // Create container for padding
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        containerView.addSubview(eyeButton)
        eyeButton.center = containerView.center

        passwordTextField.rightView = containerView
        passwordTextField.rightViewMode = .always
    }
    
    // MARK: - Toggle Password Visibility
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    // MARK: - Button Action
    @objc private func signupTapped() {
        let username = usernameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // Validation
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert("Invalid Username", "Please enter your username.")
            return
        }
        
        guard validateEmail(email) else {
            showAlert("Invalid Email", "Please enter a valid email address.")
            return
        }
        
        guard validatePassword(password) else {
            showAlert("Weak Password",
                      "Password must be at least 8 characters long, include 1 uppercase, 1 lowercase, 1 number, and 1 special character.")
            return
        }
        
        // Call backend
        viewModel.signup(username: username, email: email, password: password)
    }
    
    // MARK: - Validation
    private func validateEmail(_ email: String) -> Bool {
        let emailPattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailPattern).evaluate(with: email)
    }
    
    private func validatePassword(_ password: String) -> Bool {
        let passwordPattern = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordPattern).evaluate(with: password)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.applyGradientBackground()
        
        titleLabel.text = "Create Account"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            usernameTextField,
            emailTextField,
            passwordTextField,
            signupButton
        ])
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
    
    // MARK: - Alert
    private func showAlert(_ title: String, _ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default) { _ in completion?() })
        present(alert, animated: true)
    }
}


private func createCustomTextField(placeholder: String, isSecure: Bool = false) -> CustomTextField {
    let tf = CustomTextField(placeholder: placeholder, isSecure: isSecure)
    tf.textColor = .black // Darker text
    tf.tintColor = .darkGray // Cursor color
    tf.attributedPlaceholder = NSAttributedString(
        string: placeholder,
        attributes: [.foregroundColor: UIColor.darkGray] // Darker placeholder
    )
    return tf
}


#Preview {
    SignupViewController()
}
