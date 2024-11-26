//
//  DishCell.swift
//  Rollen
//
//  Created by Dmitry Belov on 26.11.2024.
//

import UIKit

class DishCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let ingredientsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ingredientsLabel)
        
        NSLayoutConstraint.activate([
            // Logo constraints
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: topInset + 40),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            // Welcome label constraints
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Welcome Text label constraints
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Start button constraints
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
    
    func configure(with dish: Dish) {
        nameLabel.text = dish.name
        ingredientsLabel.text = dish.ingredients
        imageView.image = UIImage(named: dish.imageName)
    }
}
