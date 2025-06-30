//
//  TemplatesResultRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol TemplatesResultRouterProtocol: AnyObject {
    func popVC()
}

final class TemplatesResultRouter: TemplatesResultRouterProtocol {
    
    weak var view: TemplatesResultView?
    weak var presenter: TemplatesResultPresenterProtocol?
    weak var delegate: EffectRouterProtocol?
    
    //MARK: - Module Builder
    static func build(_ videoUrl: String, delegate: EffectRouterProtocol) -> UIViewController {
        let view = TemplatesResultView()
        let interactor = TemplatesResultInteractor()
        let router = TemplatesResultRouter()
        let presenter = TemplatesResultPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        view.videoURL = videoUrl
        presenter.view = view
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        router.delegate = delegate
        
        return view
    }
    
    func popVC() {
        delegate?.popVC()
    }
}
