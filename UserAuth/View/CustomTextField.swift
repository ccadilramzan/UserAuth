//
//  CustomTextField.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

import SwiftUI
// View/CustomTextField.swift
import UIKit

final class CustomTextField: UITextField {
    
    init(placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecure
        self.borderStyle = .none
        self.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        self.layer.cornerRadius = 12
        self.textColor = .white
        self.setLeftPadding(12)
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension UITextField {
//    func setLeftPadding(_ amount: CGFloat) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//}

#Preview {
    CustomTextField(placeholder: "Email")
}
