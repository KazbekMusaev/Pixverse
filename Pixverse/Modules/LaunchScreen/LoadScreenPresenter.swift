//
//  LoadScreenPresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 02.07.2025.
//

import UIKit

protocol LoadScreenPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func tapToShowPaywall()
    func goToMainScreen()
}

final class LoadScreenPresenter: LoadScreenPresenterProtocol {
    
    static func build() -> UIViewController {
        let view = LaunchScreenViewController()
        let presenter = LoadScreenPresenter()
        presenter.view = view
        view.presenter = presenter
        return view
    }
    
    func tapToShowPaywall() {
        print("need add paywall ")
    }
    
    func goToMainScreen() {
        AppFlowController.shared.rootViewControllerRelay.accept(MainTabBar())
    }
    
    func viewDidLoaded() {
        view?.showPages()
    }
    
    
    weak var view: LaunchScreenViewControllerProtocol?
    
}
