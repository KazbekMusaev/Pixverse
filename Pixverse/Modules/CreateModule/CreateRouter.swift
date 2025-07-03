//
//  CreateRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

protocol CreateRouterProtocol: AnyObject {
    func pushToTextToVideo()
    func pushToImgAndTextToVideo()
    func pushToSeeAll(_ model: [TemplatesModel])
    func pushToEffect(model: TemplatesModel)
}

final class CreateRouter: CreateRouterProtocol {
    func pushToEffect(model: TemplatesModel) {
        let vc = EffectRouter.build(model)
        viewController?.navigationController?.pushViewController(vc, animated: true)
        TabBarManager.shared.hide()
    }
    
    func pushToSeeAll(_ model: [TemplatesModel]) {
        guard let presenter else { return }
        let vc = SeeAllEffectsRouter.build(delegate: presenter, model: model)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToImgAndTextToVideo() {
        let vc = ImgAndTextToVideoRouter.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
        TabBarManager.shared.hide()
    }
    
    
    func pushToTextToVideo() {
        let vc = TextToVideoRouter.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
        TabBarManager.shared.hide()
    }
    
    
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
        navController.navigationBar.isHidden = true
        
        return navController
    }
    
}
