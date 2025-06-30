//
//  TabBarManager.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import RxSwift
import RxCocoa

class TabBarManager {
    static let shared = TabBarManager()
    private init() {}
    
    private let _isHidden = BehaviorRelay<Bool>(value: false)
    var isHidden: Driver<Bool> { return _isHidden.asDriver() }
    
    func toggle(animated: Bool = true) {
        _isHidden.accept(!_isHidden.value)
    }
    
    func hide(animated: Bool = true) {
        _isHidden.accept(true)
    }
    
    func show(animated: Bool = true) {
        _isHidden.accept(false)
    }
}
