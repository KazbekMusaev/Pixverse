//
//  SeeAllEffectsRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol SeeAllEffectsRouterProtocol: AnyObject {
    
}

final class SeeAllEffectsRouter: SeeAllEffectsRouterProtocol {
    
    weak var view: SeeAllEffectsView?
    weak var presenter: SeeAllEffectsPresenterProtocol?
    
    //MARK: - Module Builder
    static func build() -> UIViewController {
        let view = SeeAllEffectsView()
        let interactor = SeeAllEffectsInteractor()
        let router = SeeAllEffectsRouter()
        let presenter = SeeAllEffectsPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        
        return view
    }
}
