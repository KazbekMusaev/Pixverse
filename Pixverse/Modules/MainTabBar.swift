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
        
        let topBorder = UIView()
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.heightAnchor.constraint(equalToConstant: 0.33).isActive = true
        topBorder.backgroundColor = .white.withAlphaComponent(0.16)
        
        tabBar.addSubview(topBorder)
        
        NSLayoutConstraint.activate([
            topBorder.topAnchor.constraint(equalTo: tabBar.topAnchor),
            topBorder.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            topBorder.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor)
        ])
        
        tabBar.tintColor = .accent
        tabBar.unselectedItemTintColor = .labelQuaternary
        
        viewControllers = [createVC, mineVC, settingsVC]
    }
    
}
