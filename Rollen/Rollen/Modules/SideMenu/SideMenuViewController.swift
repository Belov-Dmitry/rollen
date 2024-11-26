//
//  SideMenuViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 28.10.2024.
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: SideMenuViewController.MenuOption)
}

class SideMenuViewController: UIViewController {
    
    enum MenuOption: String, CaseIterable {
        case profile = "Profile"
        case wishlist = "Wishlist"
        case loyaltyPoints = "Loyalty Points"
        case paymentMethods = "Payment Methods"
        
        var imageName: String {
            switch self {
            case .profile: return ImageName.menuProfile
            case .wishlist: return ImageName.menuWishlist
            case .loyaltyPoints: return ImageName.menuLoyaltyPoints
            case .paymentMethods: return ImageName.menuPaymentMethods
            }
        }
    }
    
    weak var delegate: SideMenuViewControllerDelegate?
    
    private  let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = AppColors.Red.medium
        tableView.separatorColor = .white
        tableView.rowHeight = 75
        tableView.tintColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let bluredBackView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = AppColors.Red.mediumTransparent
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = element.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.translatesAutoresizingMaskIntoConstraints = false
        element.addSubview(blurView)
        element.sendSubviewToBack(blurView)
        return element
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = AppColors.Red.medium
        view.addSubview(bluredBackView)
        //bluredBackView.addSubview(tableView)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        setupLayout()
        setupGestures()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            bluredBackView.topAnchor.constraint(equalTo: view.topAnchor),
            bluredBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bluredBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bluredBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor) ])
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBluredBackView))
        bluredBackView.addGestureRecognizer(tapGesture)
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        swipeLeftGesture.direction = .left
        bluredBackView.addGestureRecognizer(swipeLeftGesture)
    }
    @objc private func didTapBluredBackView() {
        dismiss(animated: true, completion: nil)
    }
    @objc private func didSwipeLeft() {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font = .boldSystemFont(ofSize: 16)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Name person"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOption.allCases[indexPath.row].rawValue
        cell.backgroundColor = AppColors.Red.medium
        cell.contentView.backgroundColor = AppColors.Red.medium
        cell.textLabel?.textColor = .white
        cell.imageView?.tintColor = .white
        cell.imageView?.image = UIImage(named: MenuOption.allCases[indexPath.row].imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = MenuOption.allCases[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        print(item)
        delegate?.didSelect(menuItem: item)
        dismiss(animated: true, completion: nil)
    }
}
