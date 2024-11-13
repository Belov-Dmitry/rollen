//
//  LogoView.swift
//  Rollen
//
//  Created by Dmitry Belov on 08.11.2024.
//

import UIKit

final class LogoView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        setupLogoView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLogoView() {
        image = UIImage(named: ImageName.logo)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 15, height: 15)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
