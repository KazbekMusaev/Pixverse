//
//  MineView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 28.06.2025.
//

import UIKit

protocol MineViewProtocol: AnyObject {
    func showInformations()
    func reloadData(_ model: [VideoModel])
    func dataIsEmpty()
    
    func reloadFavorite()
}

final class MineView: UIViewController {

    private var model: [VideoModel] = []
    private var favoritesModel: [VideoModel] = []
    
    var presenter: MinePresenterProtocol?
    
    var selectedCollectionType: Bool = false
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        presenter?.viewWillAppear()
//    }
    
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
    
    private func settupEmptyView() {
        savedVideoCollectionView.removeFromSuperview()
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    private func settupWithCollection() {
        emptyView.removeFromSuperview()
        view.addSubview(allVideoBtn)
        view.addSubview(favoriteVideoBtn)
        view.addSubview(savedVideoCollectionView)
        
        NSLayoutConstraint.activate([
            allVideoBtn.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 16),
            allVideoBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            favoriteVideoBtn.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 16),
            favoriteVideoBtn.leadingAnchor.constraint(equalTo: allVideoBtn.trailingAnchor, constant: 8),
            
            savedVideoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedVideoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedVideoCollectionView.topAnchor.constraint(equalTo: favoriteVideoBtn.bottomAnchor, constant: 20),
            savedVideoCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func changeModel() {
        if selectedCollectionType {
            model = favoritesModel
            savedVideoCollectionView.reloadData()
        } else {
            model = CoreManager.shared.posts
            savedVideoCollectionView.reloadData()
        }
    }
    
    //MARK: - View elements
    private lazy var navBar = ComponentBuilder.getCustomNavigationBar(title: "Mine")
    
    private lazy var savedVideoCollectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(MineVideoCell.self, forCellWithReuseIdentifier: MineVideoCell.reuseId)
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.itemSize = CGSize(width: view.frame.width - 32, height: 180)
        $0.minimumLineSpacing = 8
        $0.scrollDirection = .vertical
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var emptyView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        
        $0.addSubview(createBtn)
        $0.addSubview(emptyViewWithoutBtn)
        
        NSLayoutConstraint.activate([
            createBtn.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 16),
            createBtn.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -16),
            createBtn.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -240),
            
            emptyViewWithoutBtn.topAnchor.constraint(equalTo: $0.topAnchor),
            emptyViewWithoutBtn.leadingAnchor.constraint(equalTo: $0.leadingAnchor),
            emptyViewWithoutBtn.trailingAnchor.constraint(equalTo: $0.trailingAnchor),
            emptyViewWithoutBtn.bottomAnchor.constraint(equalTo: createBtn.topAnchor, constant: -20),
        ])
        
        return $0
    }(UIView())
    
    private lazy var createBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtn(action: createAction, text: "Create")
        DispatchQueue.main.async {
            btn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
        }
        return btn
    }()
    
    private lazy var emptyViewWithoutBtn = ComponentBuilder.getEmptyView()
    
    private lazy var allVideoBtn: UIButton = {
        let btn = ComponentBuilder.getSmallBtn(action: allVideoAction, label: allVideoLabel)
        return btn
    }()
    
    private lazy var favoriteVideoBtn: UIButton = {
        let btn = ComponentBuilder.getSmallBtn(action: favoriteVideoAction, label: favoriteVideoLabel, isFavorite: true)
        return btn
    }()

    private lazy var allVideoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 13) // SF PRO
        $0.textColor = .labelPrimary
        $0.text = "All videos"
        return $0
    }(UILabel())
    
    private lazy var favoriteVideoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 13) // SF PRO
        $0.textColor = .labelTertiary
        $0.text = "My favorites"
        return $0
    }(UILabel())
    
    //MARK: - Actions
    private lazy var createAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.createBtn.clickAnimate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presenter?.touchCreateBtn()
        }
    }
    
    private lazy var allVideoAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.allVideoBtn.clickAnimate()
        self.selectedCollectionType = false
        
        self.allVideoLabel.textColor = .labelPrimary
        self.favoriteVideoLabel.textColor = .labelTertiary
        
        self.allVideoBtn.backgroundColor = .backgroundSecondary
        self.favoriteVideoBtn.backgroundColor = .backgroundTertiary
        
        self.changeModel()
    }
    
    private lazy var favoriteVideoAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.favoriteVideoBtn.clickAnimate()
        self.selectedCollectionType = true
        
        self.favoriteVideoLabel.textColor = .labelPrimary
        self.allVideoLabel.textColor = .labelTertiary
        
        self.allVideoBtn.backgroundColor = .backgroundTertiary
        self.favoriteVideoBtn.backgroundColor = .backgroundSecondary
        
        self.changeModel()
    }
    
}

extension MineView: MineViewProtocol {
    func reloadFavorite() {
        favoritesModel = CoreManager.shared.posts.filter({ $0.favorite })
        favoriteVideoLabel.text = "My favorites (\(favoritesModel.count))"
    }
    
    
    func reloadData(_ model: [VideoModel]) {
        settupWithCollection()
        self.model = model
        allVideoLabel.text = "All videos (\(model.count))"
        
        favoritesModel = model.filter({ $0.favorite })
        favoriteVideoLabel.text = "My favorites (\(favoritesModel.count)"
        
        savedVideoCollectionView.reloadData()
    }
    
    func showInformations() {
        settupView()
    }
    
    func dataIsEmpty() {
        settupEmptyView()
    }
}

extension MineView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.itemIsSelect(model: model[indexPath.item])
    }
}


extension MineView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MineVideoCell.reuseId, for: indexPath) as? MineVideoCell else {
            return UICollectionViewCell()
        }
        cell.configireCell(model: model[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    
}
