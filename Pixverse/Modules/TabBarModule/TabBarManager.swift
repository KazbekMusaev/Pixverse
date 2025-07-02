//
//  TabBarManager.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit
import RxSwift
import RxCocoa

class TabBarManager {
    static let shared = TabBarManager()
    private init() {}
    
    private let _isHidden = BehaviorRelay<Bool>(value: false)
    var isHidden: Driver<Bool> { return _isHidden.asDriver() }
    
    private let _selectedIndex = BehaviorRelay<Int>(value: 0)
    var selectedIndex: Driver<Int> { return _selectedIndex.asDriver() }
    
    weak var tabBarController: UITabBarController?
    
    func toggle(animated: Bool = true) {
        _isHidden.accept(!_isHidden.value)
    }
    
    func hide(animated: Bool = true) {
        _isHidden.accept(true)
    }
    
    func show(animated: Bool = true) {
        _isHidden.accept(false)
    }
    
    func selectTab(at index: Int) {
        guard index >= 0 && index < (tabBarController?.viewControllers?.count ?? 0) else { return }
        _selectedIndex.accept(index)
        tabBarController?.selectedIndex = index
    }
    
    func selectCreateTab() {
        selectTab(at: 0)
    }
    
    func selectMineTab() {
        selectTab(at: 1)
    }
    
    func selectSettingsTab() {
        selectTab(at: 2)
    }
    
}
