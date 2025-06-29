//
//  MineView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 28.06.2025.
//

import UIKit

protocol MineViewProtocol: AnyObject {
    func showInformations()
}

final class MineView: UIViewController {

    var presenter: MinePresenterProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(navBar)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
        ])
    }
    
    //MARK: - View elements
    private lazy var navBar = ComponentBuilder.getCustomNavigationBar(title: "Mine")
    
    //MARK: - Actions

}

extension MineView: MineViewProtocol {
    func showInformations() {
        settupView()
    }
}
