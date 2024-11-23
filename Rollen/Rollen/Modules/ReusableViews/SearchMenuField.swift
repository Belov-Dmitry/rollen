//
//  SearchMenuField.swift
//  Rollen
//
//  Created by Dmitry Belov on 23.11.2024.
//
import UIKit

class SearchMenuField: UITextField {

    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        layer.cornerRadius = 24
        backgroundColor = .white.withAlphaComponent(0.3)
        font = .boldSystemFont(ofSize: 16)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        
        attributedPlaceholder = NSAttributedString(string:"Search Menu", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5)])
        
        let imageView = UIImageView(frame: CGRect(x: 60, y: 2, width: 20, height: 20))
        imageView.tintColor = .black.withAlphaComponent(0.5)
        imageView.image = UIImage(systemName: "magnifyingglass")
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 60 + 20 + 10, height: 22))
        leftPaddingView.addSubview(imageView)
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.height))
        
        leftView = leftPaddingView
        rightView = rightPaddingView
        leftViewMode = .always
        rightViewMode = .always
    }
}
