//
//  RegisterTextField.swift
//  Rollen
//
//  Created by Dmitry Belov on 09.11.2024.
//
import UIKit

class RegisterTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    
    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func setupTextField(placeholder: String) {
        textColor = AppColors.registerTextFieldTextColor
        font = .boldSystemFont(ofSize: 15)
        layer.cornerRadius = 25
        self.backgroundColor = AppColors.registerTextFieldBackgroundColor
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2])
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
