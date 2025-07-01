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
    func pushToResult(_ videoUrl: String, filePath: String)
}

final class EffectRouter: EffectRouterProtocol {
    func pushToResult(_ videoUrl: String, filePath: String) {
        let vc = TemplatesResultRouter.build(videoUrl, delegate: self, localFilePath: filePath)
        view?.navigationController?.pushViewController(vc, animated: true)
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
        
        interactor.saveVideoModel = SaveVideoModel(name: model.name, date: Date())
        
        return view
    }
    
    func presentAddPhotoHelper() {
        let vc = AddPhotoHelperView()
        vc.delegate = view
        
        vc.modalPresentationStyle = .formSheet
        vc.modalTransitionStyle = .flipHorizontal
        
        
        view?.present(vc, animated: true)
    }
    
    func popVC() {
        TabBarManager.shared.show()
        if let targetVC = view?.navigationController?.viewControllers.first(where: { $0 is CreateView }) {
            view?.navigationController?.popToViewController(targetVC, animated: true)
        }
    }
}
