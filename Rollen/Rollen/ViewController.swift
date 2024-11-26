//
//  ViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 25.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tempLabel: UILabel = {
        let element = UILabel()
        element.text = "Hellow World"
        element.translatesAutoresizingMaskIntoConstraints = false
        
        return element
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        
        view.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            tempLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tempLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20)
        ])
        tempLabel.font = .Sen.bold.size(of: 40)
        tempLabel.textColor = AppColors.Yellow.medium
        
    }

 
}

