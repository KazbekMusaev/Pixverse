//
//  SettingsView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 28.06.2025.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func showInformations()
}

final class SettingsView: UIViewController {

    var presenter: SettingsPresenterProtocol?
    
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
    private lazy var navBar = ComponentBuilder.getCustomNavigationBar(title: "Settings")
    
    
    //MARK: - Actions

}

extension SettingsView: SettingsViewProtocol {
    func showInformations() {
        settupView()
    }
}
