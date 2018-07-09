//
//  Extension.swift
//  ProductReview
//
//  Created by Pisit Lolak on 7/7/2561 BE.
//  Copyright © 2561 Pisit Lolak. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIViewController {
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
