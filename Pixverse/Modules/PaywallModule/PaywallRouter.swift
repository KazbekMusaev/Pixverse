//
//  PaywallRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 03.07.2025.
//

import UIKit

protocol PaywallRouterProtocol: AnyObject {
    func popVC()
}

final class PaywallRouter: PaywallRouterProtocol {
    
    func popVC() {
        TabBarManager.shared.show()
        view?.navigationController?.popViewController(animated: true)
    }
    
    weak var view: PaywallView?
    weak var presenter: PaywallPresenterProtocol?
    
    
    //MARK: - Module Builder
    static func build() -> UIViewController {
        let view = PaywallView()
        let router = PaywallRouter()
        let interactor = PaywallInteractor()
        let presenter = PaywallPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        
        return view
    }
}
