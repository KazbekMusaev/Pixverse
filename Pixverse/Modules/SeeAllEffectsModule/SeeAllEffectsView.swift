//
//  SeeAllEffectsView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol SeeAllEffectsViewProtocol: AnyObject {
    func showInformation()
}

final class SeeAllEffectsView: UIViewController {
    
    var presenter: SeeAllEffectsPresenterProtocol?
    var delegate: CreatePresenterProtocol?
    var model: [TemplatesModel] = []
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    

    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(navBar)
        view.addSubview(effectCollectionView)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            effectCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            effectCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            effectCollectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            effectCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: - View elements
    private lazy var navBar = ComponentBuilder.getCustomNavigationBar(title: "Effects")
    
    private lazy var effectCollectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(TemplatesCell.self, forCellWithReuseIdentifier: TemplatesCell.reuseId)
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.itemSize = CGSize(width: (view.frame.width - 48) / 2, height: 250)
        $0.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        $0.minimumLineSpacing = 20
        return $0
    }(UICollectionViewFlowLayout())
    
    //MARK: - Actions

}

extension SeeAllEffectsView: SeeAllEffectsViewProtocol {
    func showInformation() {
        settupView()
    }
}


extension SeeAllEffectsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.needPopVC()
        delegate?.selectItemInCollection(model: model[indexPath.item])
    }
}

extension SeeAllEffectsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplatesCell.reuseId, for: indexPath) as? TemplatesCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(model[indexPath.item])
        return cell
    }
    
    
}
