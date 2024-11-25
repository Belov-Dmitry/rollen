//
//  SideMenuViewController.swift
//  Rollen
//
//  Created by Dmitry Belov on 04.11.2024.
//

//import UIKit
//
//protocol SideMenuViewControllerDelegate: AnyObject {
//    func didSelect(menuItem: SideMenuViewController.MenuOption)
//}
//
//class SideMenuViewController: UIViewController {
//    
//    enum MenuOption: String, CaseIterable {
//            case profile = "Profile"
//            case wishlist = "Wishlist"
//            case loyaltyPoints = "Loyalty Points"
//            case paymentMethods = "Payment Methods"
//    
//            var imageName: String {
//                switch self {
//                case .profile: return ImageName.menuProfile
//                case .wishlist: return ImageName.menuWishlist
//                case .loyaltyPoints: return ImageName.menuLoyaltyPoints
//                case .paymentMethods: return ImageName.menuPaymentMethods
//                }
//            }
//        }
//    
//        weak var delegate: SideMenuViewControllerDelegate?
// 
//    private  let tableView: UITableView = {
//            let tableView = UITableView()
//            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//            tableView.backgroundColor = AppColors.Red.medium
//            tableView.separatorColor = .white
//            tableView.rowHeight = 75
//            tableView.tintColor = .white
//            return tableView
//        }()
//    
////MARK: - LifeCycle
//        override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//            tableView.frame = CGRect(x: 0, y: Int(view.safeAreaInsets.top + 100), width: Int(view.bounds.size.width), height: Int(view.bounds.size.height))
//        }
//    
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            view.backgroundColor = AppColors.Red.medium
//            view.addSubview(tableView)
//            tableView.dataSource = self
//            tableView.delegate = self
//        }
//    
//}
////MARK: - UITableViewDataSource, UITableViewDelegate
//extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? UITableViewHeaderFooterView {
//            headerView.textLabel?.textColor = .white
//            headerView.textLabel?.font = .boldSystemFont(ofSize: 16)
//           }
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "Name person"
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        100
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        MenuOption.allCases.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = MenuOption.allCases[indexPath.row].rawValue
//        cell.backgroundColor = AppColors.Red.medium
//        cell.contentView.backgroundColor = AppColors.Red.medium
//        cell.textLabel?.textColor = .white
//        cell.imageView?.tintColor = .white
//        cell.imageView?.image = UIImage(named: MenuOption.allCases[indexPath.row].imageName)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if let indexPath = tableView.indexPathForSelectedRow {
//
//            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
//
//            currentCell.alpha = 0.5
//            UIView.animate(withDuration: 1, animations: {
//                currentCell.alpha = 1
//            })
//
//            tableView.deselectRow(at: indexPath, animated: true)
//            let item = MenuOption.allCases[indexPath.row]
//            printf(item)
//            //delegate?.didSelect(menuItem: item)
//        }
//    }
//}
//








//protocol SideMenuViewControllerDelegate: AnyObject {
//    func didSelect(menuItem: SideMenuViewController.MenuOption)
//}
//class SideMenuViewController: UIViewController {
//    
//    enum MenuOption: String, CaseIterable {
//        case profile = "Profile"
//        case wishlist = "Wishlist"
//        case loyaltyPoints = "Loyalty Points"
//        case paymentMethods = "Payment Methods"
//        
//        var imageName: String {
//            switch self {
//            case .profile: return ImageName.menuProfile
//            case .wishlist: return ImageName.menuWishlist
//            case .loyaltyPoints: return ImageName.menuLoyaltyPoints
//            case .paymentMethods: return ImageName.menuPaymentMethods
//            }
//        }
//    }
//    
//    weak var delegate: SideMenuViewControllerDelegate?
//    
//    private  let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.backgroundColor = .accentRed
//        tableView.separatorColor = .white
//        tableView.rowHeight = 75
//        tableView.tintColor = .white
//        return tableView
//    }()
//    
//    
//    //MARK: - LifeCycle
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = CGRect(x: 0, y: Int(view.safeAreaInsets.top + 100), width: Int(view.bounds.size.width), height: Int(view.bounds.size.height))
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .accentRed
//        view.addSubview(tableView)
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//}
////MARK: - UITableViewDataSource, UITableViewDelegate
//extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? UITableViewHeaderFooterView {
//            headerView.textLabel?.textColor = .white
//            headerView.textLabel?.font = .boldSystemFont(ofSize: 16)
//           }
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "Name person"
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        100
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        MenuOption.allCases.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = MenuOption.allCases[indexPath.row].rawValue
//        cell.backgroundColor = .accentRed
//        cell.contentView.backgroundColor = .accentRed
//        cell.textLabel?.textColor = .white
//        cell.imageView?.tintColor = .white
//        cell.imageView?.image = UIImage(named: MenuOption.allCases[indexPath.row].imageName)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    
//        if let indexPath = tableView.indexPathForSelectedRow {
//            
//            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
//        
//            currentCell.alpha = 0.5
//            UIView.animate(withDuration: 1, animations: {
//                currentCell.alpha = 1
//            })
//            
//            tableView.deselectRow(at: indexPath, animated: true)
//            let item = MenuOption.allCases[indexPath.row]
//            delegate?.didSelect(menuItem: item)
//        }
//    }
//}
