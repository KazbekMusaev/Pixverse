//
//  SettingsRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

protocol SettingsRouterProtocol: AnyObject {
    
}

final class SettingsRouter: SettingsRouterProtocol {
    
    weak var presenter: SettingsPresenterProtocol?
    
    
    //MARK: - ModuleBuilder
    static func build() -> UIViewController {
        let viewController = SettingsView()
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
        let presenter = SettingsPresenter(router: router, interactor: interactor)
        
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
    }
}
