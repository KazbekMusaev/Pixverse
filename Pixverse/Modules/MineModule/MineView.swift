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
    
    //MARK: - View elements
    
    //MARK: - Actions

}

extension MineView: MineViewProtocol {
    func showInformations() {
        print("MineView -> show informations")
    }
}
