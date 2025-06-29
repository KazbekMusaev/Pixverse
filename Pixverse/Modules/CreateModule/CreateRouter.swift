//
//  CreateRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

protocol CreateRouterProtocol: AnyObject {
    
}

final class CreateRouter: CreateRouterProtocol {
    
    weak var viewController: CreateView?
    weak var presenter: CreatePresenterProtocol?
    
    
    //MARK: - ModuleBuilder
    static func build() -> UINavigationController {
        let viewController = CreateView()
        let interactor = CreateInteractor()
        let router = CreateRouter()
        let presenter = CreatePresenter(interactor: interactor, router: router)
        
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
        router.viewController = viewController
        
        let navController = UINavigationController(rootViewController: viewController)
        
        return navController
    }


    
}
