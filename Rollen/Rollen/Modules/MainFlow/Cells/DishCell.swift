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
    private let weightLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dish: Dish) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "RUB"
        formatter.currencySymbol = "₽"
        formatter.maximumFractionDigits = 0
        if let formattedPrice = formatter.string(from: NSNumber(value: dish.price)) {
            priceLabel.text = formattedPrice
        } else {
            priceLabel.text = "Цена недоступна"
        }
        nameLabel.text = dish.name
        ingredientsLabel.text = dish.ingredients
        weightLabel.text = "\(dish.weight) г"
        imageView.image = UIImage(named: dish.imagename)
    }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .systemFont(ofSize: 24)
        nameLabel.textColor = AppColors.dishesNameColor
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsLabel.font = .systemFont(ofSize: 16)
        ingredientsLabel.textColor = AppColors.dishesIngredientsColor
        ingredientsLabel.numberOfLines = 2
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weightLabel.font = .systemFont(ofSize: 18)
        weightLabel.textColor = AppColors.dishesWeightColor
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = .systemFont(ofSize: 18)
        priceLabel.textColor = .white
        priceLabel.backgroundColor = AppColors.dishesPriceBackgroundColor
        priceLabel.layer.cornerRadius = 6
        priceLabel.clipsToBounds = true
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(weightLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            ingredientsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            ingredientsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ingredientsLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 4),
            weightLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            weightLabel.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor,constant: 60),
            
            priceLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -100),
            priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
