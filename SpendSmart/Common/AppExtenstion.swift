//
//  AppExtenstion.swift
//  HCLTask
//
//  Created by Abinash Reddy on 11/05/24.
//

import Foundation
import UIKit

extension UIViewController {
    enum Storyboard: String {
        case main = "Main"
    }
    
    class func controller(with stroyboard: Storyboard, identifier: String) -> UIViewController {
        return UIStoryboard(name: stroyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}
