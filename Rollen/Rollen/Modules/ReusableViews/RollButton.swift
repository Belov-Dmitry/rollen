//
//  RollButton.swift
//  Rollen
//
//  Created by Dmitry Belov on 08.11.2024.
//

import UIKit

class RollButton: UIButton {
    
    enum Size {
        case small
        case large
        case square
        
        var dimensions: (width: CGFloat, height: CGFloat) {
            switch self {
            case .small:
                return (120, 64)
            case .large:
                return (220, 40)
            case .square:
                return (80, 24)
            }
        }
        var cornerRadius: CGFloat {
            switch self {
            case .small:
                return 32
            case .large:
                return 20
            case .square:
                return 6
            }
        }
        var fontSize: CGFloat {
            switch self {
            case .small:
                return 20
            case .large:
                return 16
            case .square:
                return 8
            }
        }
    }
    
    private let buttonSize: Size
    
    init(text: String, size: Size) {
        self.buttonSize = size
        super.init(frame: .zero)
        
        setupButton(with: text)
        configureSize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupButton
    private func setupButton(with text: String) {
        setTitle(text, for: .normal)
        backgroundColor = AppColors.addButton
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: buttonSize.fontSize)
        layer.cornerRadius = buttonSize.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
    }
    private func configureSize() {
        let dimensions = buttonSize.dimensions
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: dimensions.width),
            heightAnchor.constraint(equalToConstant: dimensions.height)
        ])
    }
}

