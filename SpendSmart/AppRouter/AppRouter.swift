//
//  AppRouter.swift
//  HCLTask
//
//  Created by Abinash Reddy on 11/05/24.
//

import Foundation
import UIKit

class AppRouter {
    
    static func navigateFrom(source: UIViewController,
                             to destination: UIViewController) {
        if source.navigationController != nil {
            source.navigationController?.pushViewController(destination, animated: true)
        } else {
            source.present(destination, animated: true)
        }
    }
    
    static func navigateToSpendDetails(controller: UIViewController) {
//        if let vc = SecondVC.linkWithStoryboard() {
//            navigateFrom(source: controller, to: vc)
//        }
    }
    
}
