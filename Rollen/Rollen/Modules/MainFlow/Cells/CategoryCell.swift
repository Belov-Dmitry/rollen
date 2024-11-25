//
//  CategoryCell.swift
//  Rollen
//
//  Created by Dmitry Belov on 14.11.2024.
//


import UIKit

class CategoryCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let backgroundLabelView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dish: DishType?) {
        titleLabel.text = dish?.dishTypeName ?? ""
        imageView.image = dish?.dishTypeImage ?? UIImage()
    }
    
    private func setupLayout() {
        backgroundLabelView.layer.masksToBounds = true
        backgroundLabelView.layoutIfNeeded()
        let maskPath = UIBezierPath(roundedRect: backgroundLabelView.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 26, height: 26))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        backgroundLabelView.layer.mask = maskLayer
    }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 26
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = AppColors.Yellow.medium
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundLabelView.backgroundColor = AppColors.Blue.darkTransparent
        backgroundLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(backgroundLabelView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.7),
            
            backgroundLabelView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundLabelView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            backgroundLabelView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            backgroundLabelView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.centerXAnchor.constraint(equalTo: backgroundLabelView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundLabelView.centerYAnchor)
        ])
    }
}
