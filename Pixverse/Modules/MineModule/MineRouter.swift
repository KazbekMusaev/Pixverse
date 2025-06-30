//
//  MineRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

protocol MineRouterProtocol: AnyObject {
    
}

final class MineRouter: MineRouterProtocol {
    
    weak var viewController: MineView?
    weak var presenter: MinePresenterProtocol?
    
    
    //MARK: - ModuleBuilder
    static func build() -> UINavigationController {
        let viewController = MineView()
        let interactor = MineInteractor()
        let router = MineRouter()
        let presenter = MinePresenter(router: router, interactor: interactor)
        
        
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
