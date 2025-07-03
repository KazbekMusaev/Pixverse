//
//  SeeAllEffectsRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol SeeAllEffectsRouterProtocol: AnyObject {
    func popVC()
}

final class SeeAllEffectsRouter: SeeAllEffectsRouterProtocol {
    func popVC() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    
    weak var view: SeeAllEffectsView?
    weak var presenter: SeeAllEffectsPresenterProtocol?
    
    weak var delegate: CreatePresenterProtocol?
    
    //MARK: - Module Builder
    static func build(delegate: CreatePresenterProtocol, model: [TemplatesModel]) -> UIViewController {
        let view = SeeAllEffectsView()
        let interactor = SeeAllEffectsInteractor()
        let router = SeeAllEffectsRouter()
        let presenter = SeeAllEffectsPresenter(router: router, interactor: interactor)
        
        view.delegate = delegate
        view.model = model
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        
        
        return view
    }
}
