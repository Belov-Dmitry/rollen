//
//  UIFont+Extention.swift
//  Rollen
//
//  Created by Dmitry Belov on 30.10.2024.
//

import UIKit

extension UIFont {
    enum Sen {
        enum bold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Sen.bold, size: size)!
            }
        }
        enum extraBold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Sen.extraBold, size: size)!
            }
        }
        enum medium {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Sen.medium, size: size)!
            }
        }
        enum regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Sen.regular, size: size)!
            }
        }
        enum semiBold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Sen.semiBold, size: size)!
            }
        }
    }
}
private extension UIFont {
    enum Constants {
        enum Sen {
            static let bold = "Sen-Bold"
            static let extraBold = "Sen-ExtraBold"
            static let medium = "Sen-Medium"
            static let regular = "Sen-Regular"
            static let semiBold = "Sen-SemiBold"
        }
    }
}
