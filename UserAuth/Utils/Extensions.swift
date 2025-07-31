//
//  Extensions.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

// Utils/Extensions.swift

import UIKit

extension UIView {
    func applyGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
    
    func setLeftPadding(_ amount: CGFloat) {
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        if let textField = self as? UITextField {
            textField.leftView = padding
            textField.leftViewMode = .always
        }
    }
}

