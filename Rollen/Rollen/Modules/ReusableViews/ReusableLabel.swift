//
//  ReusableLabel.swift
//  Rollen
//
//  Created by Dmitry Belov on 30.11.2024.
//

import UIKit

class ReusableLabel: UILabel {

    init(text: String, fontSize: CGFloat, weight: UIFont.Weight) {
        super.init(frame: .zero)

        self.text = text
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = .white
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
