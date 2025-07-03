//
//  MainTabBar.swift
//  Pixverse
//
//  Created by KazbekMusaev on 28.06.2025.
//

import UIKit

import UIKit
import RxSwift

final class MainTabBar: UITabBarController {
    private let disposeBag = DisposeBag()
    private var originalTabBarFrame: CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let createVC = CreateRouter.build()
        createVC.tabBarItem.image = UIImage(systemName: "leaf.circle.fill")
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
        
        originalTabBarFrame = tabBar.frame
        
        TabBarManager.shared.tabBarController = self
        
        setupTabBarObservables()
    }
    
    private func setupTabBarObservables() {
        TabBarManager.shared.isHidden
            .drive(onNext: { [weak self] isHidden in
                self?.animateTabBar(hidden: isHidden)
            })
            .disposed(by: disposeBag)
        TabBarManager.shared.selectedIndex
                   .drive(onNext: { [weak self] index in
                       self?.selectedIndex = index
                   })
                   .disposed(by: disposeBag)
    }
    
    private func animateTabBar(hidden: Bool) {
        UIView.animate(withDuration: 0.3) {
            if hidden {
                self.tabBar.isHidden = true
            } else {
                self.tabBar.isHidden = false
            }
            self.view.layoutIfNeeded()
        }
    }
}
