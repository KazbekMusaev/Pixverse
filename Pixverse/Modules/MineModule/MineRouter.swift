//
//  MineRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

protocol MineRouterProtocol: AnyObject {
    func changeTab()
    func goToResultModule(fileName: String)
}

final class MineRouter: MineRouterProtocol {
    
    func goToResultModule(fileName: String) {
        let vc = TemplatesResultRouter.buildWithoutDownloads(localFilePath: fileName)
        viewController?.navigationController?.pushViewController(vc, animated: true)
        TabBarManager.shared.hide()
    }
    
    func changeTab() {
        TabBarManager.shared.selectTab(at: 0)
    }
    
    
    weak var viewController: MineView?
    weak var presenter: MinePresenterProtocol?
    
    
    //MARK: - ModuleBuilder
    static func build() -> UINavigationController {
        let viewController = MineView()
        let interactor = MineInteractor()
        let router = MineRouter()
        let presenter = MinePresenter(router: router, interactor: interactor)
        
        
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
