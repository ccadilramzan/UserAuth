//
//  LoginViewController.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// View/LoginViewController.swift

import UIKit

final class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    private lazy var emailTextField = createCustomTextField(placeholder: "Email")
    private lazy var passwordTextField = createCustomTextField(placeholder: "Password", isSecure: true)
    
    
    private let loginButton = PrimaryButton(title: "Login")
    private let titleLabel = UILabel()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        bindViewModel()
//        configureTextFields()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If user already logged in, skip login screen
        if UserCache().getCurrentUser() != nil {
            navigateToMainApp()
            return
        }
        
        setupUI()
        bindViewModel()
        configureTextFields()
    }

    private func bindViewModel() {
        viewModel.onLoginSuccess = { [weak self] in
            self?.showAlert("Success", "Login successful!") {
                self?.navigateToMainApp()
            }
        }
        
        viewModel.onLoginFailure = { [weak self] message in
            self?.showAlert("Login Failed", message)
        }
    }
    
    // MARK: - Configure TextFields
    private func configureTextFields() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textContentType = .emailAddress
        
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.textContentType = .password
        
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
    
    @objc private func loginTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        print("DEBUG: Attempting login with email=\(email), password=\(password)")
        
        guard validateEmail(email) else {
            showAlert("Invalid Email", "Please enter a valid email address.")
            return
        }
        
        guard validatePassword(password) else {
            showAlert("Weak Password",
                      "Password must be at least 8 characters long, include 1 uppercase, 1 lowercase, 1 number, and 1 special character.")
            return
        }
        
        viewModel.login(email: email, password: password)
    }

    
    // MARK: - Validation
    private func validateEmail(_ email: String) -> Bool {
        let emailPattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailPattern).evaluate(with: email)
    }
    
    private func validatePassword(_ password: String) -> Bool {
        // At least 1 uppercase, 1 lowercase, 1 digit, 1 special character, min 8 chars
        let passwordPattern = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordPattern).evaluate(with: password)
    }
    
    // MARK: - UI Setup
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
    
    // MARK: - Alert
    private func showAlert(_ title: String, _ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
    
    // MARK: - Buttons
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
    LoginViewController()
}
