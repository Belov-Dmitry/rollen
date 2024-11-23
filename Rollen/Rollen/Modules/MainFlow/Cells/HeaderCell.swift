//
//  HeaderCell.swift
//  Rollen
//
//  Created by Dmitry Belov on 14.11.2024.
//


import UIKit

class HeaderCell: UICollectionReusableView {
    
    private let sideMenuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "sideMenuButtonImage")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = AppColors.MainMenuHeaderCellColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = AppColors.MainMenuHeaderCellColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Еда, приготовленная с любовью!"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = AppColors.MainMenuHeaderCellColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let searchTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Search"
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        let magnifyingGlass = UIImage(systemName: "magnifyingglass")
//        let imageView = UIImageView(image: magnifyingGlass)
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        textField.rightView = imageView
//        textField.rightViewMode = .always
//        return textField
//    }()
    private let searchTextField = RegisterTextField(placeholder: "Search")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sideMenuButton)
        addSubview(welcomeLabel)
        addSubview(subtitleLabel)
        addSubview(searchTextField)
        
        sideMenuButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        sideMenuButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        welcomeLabel.topAnchor.constraint(equalTo: sideMenuButton.bottomAnchor, constant: 16).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 4).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        searchTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
