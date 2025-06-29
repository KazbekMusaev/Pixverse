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
    
    
    //MARK: - View elements
    
    
    //MARK: - Actions

}

extension SettingsView: SettingsViewProtocol {
    func showInformations() {
        print("SettingsView -> show informations")
    }
}
