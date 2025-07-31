//
//  PrimaryButton.swift
//  UserAuth
//
//  Created by ADIL RAMZAN on 31/07/2025.
//

import SwiftUI

// View/PrimaryButton.swift

import UIKit

final class PrimaryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = UIColor.white
        setTitleColor(.systemBlue, for: .normal)
        layer.cornerRadius = 12
        titleLabel?.font = .boldSystemFont(ofSize: 18)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        alpha = 0.9
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


#Preview {
    PrimaryButton(title: "Login")
}
