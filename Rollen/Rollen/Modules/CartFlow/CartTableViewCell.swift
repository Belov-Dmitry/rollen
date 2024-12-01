//
//  CartTableViewCell.swift
//  Rollen
//
//  Created by Dmitry Belov on 30.11.2024.
//

import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func cartTableViewCellDidUpdateQuantity(_ cell: CartTableViewCell)
}

class CartTableViewCell: UITableViewCell {
    
    weak var delegate: CartTableViewCellDelegate?
    private var dish: OrderedDish!
    
    private let dishImageView = UIImageView()
    private let dishNameLabel = ReusableLabel(text: "Dish Name", fontSize: 20, weight: .regular)
    private let minusLabel = ReusableLabel(text: "-", fontSize: 24, weight: .bold)
    private let backgroundCountLabelView = UIView()
    private let quantityLabel = ReusableLabel(text: "1", fontSize: 20, weight: .bold)
    private let plusLabel = ReusableLabel(text: "+", fontSize: 24, weight: .bold)
    private let priceLabel = ReusableLabel(text: "0.0000", fontSize: 24, weight: .regular)
    private let deleteLabel = ReusableLabel(text: "x", fontSize: 20, weight: .bold)
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dish: OrderedDish) {
        dishImageView.image = UIImage(named: dish.imagename)
        dishNameLabel.text = dish.name
        quantityLabel.text = "\(dish.quantity)"
        priceLabel.text = "\(dish.price * dish.quantity)₽"
        print("func configure(with dish: OrderedDish) - \(dish.name)")
    }
    
    private func setupUI() {
        contentView.backgroundColor = AppColors.Blue.light
        dishImageView.contentMode = .scaleAspectFill
        dishImageView.clipsToBounds = true
        dishImageView.layer.cornerRadius = 28
        //dishImageView.image = UIImage(named: "logo")
        dishImageView.translatesAutoresizingMaskIntoConstraints = false
        dishNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dishNameLabel.textAlignment = .left
        
        backgroundCountLabelView.backgroundColor = .clear//AppColors.Blue.medium
        backgroundCountLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteLabel.textColor = AppColors.Red.light
        
        contentView.addSubview(dishImageView)
        contentView.addSubview(dishNameLabel)
        contentView.addSubview(minusLabel)
        contentView.addSubview(backgroundCountLabelView)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(plusLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(deleteLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
           
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dishImageView.widthAnchor.constraint(equalToConstant: 80),
//            dishImageView.heightAnchor.constraint(equalToConstant: 80),
            dishImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            dishNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dishNameLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 10),
            dishNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            minusLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 17),
            minusLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 10),
            
            backgroundCountLabelView.centerYAnchor.constraint(equalTo: minusLabel.centerYAnchor),
            backgroundCountLabelView.leadingAnchor.constraint(equalTo: minusLabel.trailingAnchor, constant: 15),
            backgroundCountLabelView.widthAnchor.constraint(equalToConstant: 23),
            backgroundCountLabelView.heightAnchor.constraint(equalToConstant: 23),
            
            quantityLabel.centerXAnchor.constraint(equalTo: backgroundCountLabelView.centerXAnchor),
            quantityLabel.centerYAnchor.constraint(equalTo: backgroundCountLabelView.centerYAnchor),
        
            plusLabel.centerYAnchor.constraint(equalTo: backgroundCountLabelView.centerYAnchor),
            plusLabel.leadingAnchor.constraint(equalTo: backgroundCountLabelView.trailingAnchor, constant: 15),
            
            priceLabel.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            deleteLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            deleteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
//    func configure(with dish: OrderedDish) {
//            self.dish = dish
//            nameLabel.text = dish.name
//            quantityLabel.text = "\(dish.quantity)"
//            priceLabel.text = "\(dish.price * dish.quantity)₽"
//        }
    
        @objc private func decreaseQuantity() {
            if dish.quantity > 1 {
                dish.quantity -= 1
                quantityLabel.text = "\(dish.quantity)"
                priceLabel.text = "\(dish.price * dish.quantity)₽"
                delegate?.cartTableViewCellDidUpdateQuantity(self)
            }
        }
    
        @objc private func increaseQuantity() {
            dish.quantity += 1
            quantityLabel.text = "\(dish.quantity)"
            priceLabel.text = "\(dish.price * dish.quantity)₽"
            delegate?.cartTableViewCellDidUpdateQuantity(self)
        }
    
        @objc private func deleteDish() {
            delegate?.cartTableViewCellDidUpdateQuantity(self)
        }
    
    
}



//import UIKit
//
//protocol CartTableViewCellDelegate: AnyObject {
//    func cartTableViewCellDidUpdateQuantity(_ cell: CartTableViewCell)
//}
//
//class CartTableViewCell: UITableViewCell {
//    
//    weak var delegate: CartTableViewCellDelegate?
//    private var dish: OrderedDish!
//    
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 16)
//        return label
//    }()
//    
//    private let quantityControl: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .equalSpacing
//        return stackView
//    }()
//    
//    private let minusButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("-", for: .normal)
//        button.addTarget(CartTableViewCell.self, action: #selector(decreaseQuantity), for: .touchUpInside)
//        return button
//    }()
//    
//    private let quantityLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let plusButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("+", for: .normal)
//        button.addTarget(CartTableViewCell.self, action: #selector(increaseQuantity), for: .touchUpInside)
//        return button
//    }()
//    
//    private let priceLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
//    
//    private let deleteButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
//        button.tintColor = .red
//        button.addTarget(CartTableViewCell.self, action: #selector(deleteDish), for: .touchUpInside)
//        return button
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        addSubview(nameLabel)
//        addSubview(quantityControl)
//        quantityControl.addArrangedSubview(minusButton)
//        quantityControl.addArrangedSubview(quantityLabel)
//        quantityControl.addArrangedSubview(plusButton)
//        addSubview(priceLabel)
//        addSubview(deleteButton)
//        
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        quantityControl.translatesAutoresizingMaskIntoConstraints = false
//        priceLabel.translatesAutoresizingMaskIntoConstraints = false
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            
//            quantityControl.centerXAnchor.constraint(equalTo: centerXAnchor),
//            quantityControl.centerYAnchor.constraint(equalTo: centerYAnchor),
//            
//            priceLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -16),
//            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            
//            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//            deleteButton.widthAnchor.constraint(equalToConstant: 24),
//            deleteButton.heightAnchor.constraint(equalToConstant: 24)
//        ])
//    }
//    
//    func configure(with dish: OrderedDish) {
//        self.dish = dish
//        nameLabel.text = dish.name
//        quantityLabel.text = "\(dish.quantity)"
//        priceLabel.text = "\(dish.price * dish.quantity)₽"
//    }
//    
//    @objc private func decreaseQuantity() {
//        if dish.quantity > 1 {
//            dish.quantity -= 1
//            quantityLabel.text = "\(dish.quantity)"
//            priceLabel.text = "\(dish.price * dish.quantity)₽"
//            delegate?.cartTableViewCellDidUpdateQuantity(self)
//        }
//    }
//    
//    @objc private func increaseQuantity() {
//        dish.quantity += 1
//        quantityLabel.text = "\(dish.quantity)"
//        priceLabel.text = "\(dish.price * dish.quantity)₽"
//        delegate?.cartTableViewCellDidUpdateQuantity(self)
//    }
//    
//    @objc private func deleteDish() {
//        delegate?.cartTableViewCellDidUpdateQuantity(self)
//    }
//}
