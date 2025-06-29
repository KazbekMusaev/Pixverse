//
//  MainTabBar.swift
//  Pixverse
//
//  Created by KazbekMusaev on 28.06.2025.
//

import UIKit

final class MainTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let createVC = CreateRouter.build()
        createVC.tabBarItem.title = "Create"
        let mineVC = MineRouter.build()
        mineVC.tabBarItem.title = "Mine"
        mineVC.tabBarItem.image = UIImage(named: "folder")
        let settingsVC = SettingsRouter.build()
        settingsVC.tabBarItem.title = "Settings"
        settingsVC.tabBarItem.image = UIImage(named: "gearshape")
        tabBar.backgroundColor = .background
        
        let topBorder = ComponentBuilder.getDivider()
        
        tabBar.addSubview(topBorder)
        
        NSLayoutConstraint.activate([
            topBorder.topAnchor.constraint(equalTo: tabBar.topAnchor),
            topBorder.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            topBorder.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor)
        ])
        
        tabBar.tintColor = .accentPrimary
        tabBar.unselectedItemTintColor = .labelQuaternary
        
        viewControllers = [createVC, mineVC, settingsVC]
    }
    
}
