//
//  CreateView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 28.06.2025.
//

import UIKit

protocol CreateViewProtocol: AnyObject {
    func showInformations()
}

final class CreateView: UIViewController {

    var presenter: CreatePresenterProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    //MARK: - Functions
    
    //MARK: - View elements
    
    //MARK: - Actions
    
}

extension CreateView: CreateViewProtocol {
    func showInformations() {
        print("CreateView -> show informations")
    }
}
