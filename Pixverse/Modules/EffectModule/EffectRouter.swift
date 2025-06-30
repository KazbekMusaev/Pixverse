//
//  EffectRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol EffectRouterProtocol: AnyObject {
    func popVC()
    func presentAddPhotoHelper()
}

final class EffectRouter: EffectRouterProtocol {
    func presentAddPhotoHelper() {
        let vc = AddPhotoHelperView()
        vc.delegate = view
        
        vc.modalPresentationStyle = .formSheet
        vc.modalTransitionStyle = .flipHorizontal
        
        
        view?.present(vc, animated: true)
    }
    
    func popVC() {
        view?.navigationController?.popViewController(animated: true)
        TabBarManager.shared.show()
    }
    
    
    weak var view: EffectView?
    weak var presenter: EffectPresenterProtocol?
    
    //MARK: - Module Builder
    static func build(_ model: TemplatesModel) -> UIViewController {
        let view = EffectView()
        let router = EffectRouter()
        let interactor = EffectInteractor()
        let presenter = EffectPresenter(router: router, interactor: interactor)
        
        view.model = model
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        
        
        return view
    }
}
