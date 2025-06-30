//
//  ImgAndTextToVideoRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol ImgAndTextToVideoRouterProtocol: AnyObject {
    func popVC()
}

final class ImgAndTextToVideoRouter: ImgAndTextToVideoRouterProtocol {
    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    
    weak var presenter: ImgAndTextToVideoPresenterProtocol?
    weak var viewController: ImgAndTextToVideoView?

    
    //MARK: - Module Builder
    static func build() -> UIViewController {
        let view = ImgAndTextToVideoView()
        let router = ImgAndTextToVideoRouter()
        let interactor = ImgAndTextToVideoInteractor()
        let presenter = ImgAndTextToVideoPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        router.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
}
