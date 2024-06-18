//
//  TabBarController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/16/24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .sOrange
        tabBar.unselectedItemTintColor = .sMediumGray
        
        let nav1 = UINavigationController(rootViewController: MainViewController())
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let nav2 = UINavigationController(rootViewController: SettingViewController())
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([nav1, nav2], animated: false)
    }

}

