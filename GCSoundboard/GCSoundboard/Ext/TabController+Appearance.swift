//
//  TabController+Appearance.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 14/09/2019.
//  Copyright © 2019 Kieran. All rights reserved.
//

import UIKit

extension UITabBarController {
    open override func viewDidLoad() {        
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = UIColor.clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        appearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
    
    }
}
