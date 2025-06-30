//
//  TextToVideoRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol TextToVideoRouterProtocol: AnyObject {
    func popVC()
}

final class TextToVideoRouter: TextToVideoRouterProtocol {
    func popVC() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    
    weak var view: TextToVideoView?
    weak var presenter: TextToVideoPresenterProtocol?
    
    
    //MARK: - Module Builder
    static func build() -> UIViewController {
        let view = TextToVideoView()
        let interactor = TextToVideoInteractor()
        let router = TextToVideoRouter()
        let presenter = TextToVideoPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        
        return view
    }
}
