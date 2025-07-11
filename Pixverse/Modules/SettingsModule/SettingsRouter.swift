//
//  SettingsRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

protocol SettingsRouterProtocol: AnyObject {
    func pushToPaywall()
}

final class SettingsRouter: SettingsRouterProtocol {
    
    func pushToPaywall() {
        TabBarManager.shared.hide()
        let vc = PaywallRouter.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    weak var viewController: SettingsView?
    weak var presenter: SettingsPresenterProtocol?
    
    
    //MARK: - ModuleBuilder
    static func build() -> UINavigationController {
        let viewController = SettingsView()
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
        let presenter = SettingsPresenter(router: router, interactor: interactor)
        
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
        router.viewController = viewController
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.isHidden = true
        
        return navController
    }
    
    
}
