//
//  AppFlowController.swift
//  Pixverse
//
//  Created by KazbekMusaev on 02.07.2025.
//

import UIKit
import RxSwift
import RxCocoa

final class AppFlowController {

    static let shared = AppFlowController()
    
    private var window: UIWindow?
    let rootViewControllerRelay = BehaviorRelay<UIViewController?>(value: nil)
    private let disposeBag = DisposeBag()

    private init() {}

    func setup(with window: UIWindow) {
        self.window = window
        bindRootChange()
    }

    private func bindRootChange() {
        rootViewControllerRelay
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] newRoot in
                self?.setRoot(newRoot)
            })
            .disposed(by: disposeBag)
    }

    private func setRoot(_ vc: UIViewController) {
        guard let window = window else {
            print("window всё ещё nil в setRoot")
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()

        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve], animations: nil)
    }
}
