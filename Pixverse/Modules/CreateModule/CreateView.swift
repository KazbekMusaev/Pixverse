//
//  CreateView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 28.06.2025.
//

import UIKit

protocol CreateViewProtocol: AnyObject {
    func showInformations()
    func tapToSeeAllBtn(_ numberOfSection: Int)
    func finishLoadData(_ model: [TemplatesModel])
    func showErrorLoad(_ errorText: String)
}

final class CreateView: UIViewController {

    var allEffects: [TemplatesModel] = []
    var popularEffects: [TemplatesModel] = []
    
    var presenter: CreatePresenterProtocol?
    
    private lazy var widthWithInsert = (view.frame.width - 48) / 2
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(navBar)
        view.addSubview(letsCreateTitle)
        view.addSubview(textToVideoBtn)
        view.addSubview(imageAndTextToVideoBtn)
        view.addSubview(templatesCollectionView)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            letsCreateTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            letsCreateTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            letsCreateTitle.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 16),
            
            textToVideoBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textToVideoBtn.topAnchor.constraint(equalTo: letsCreateTitle.bottomAnchor, constant: 12),
            textToVideoBtn.widthAnchor.constraint(equalToConstant: widthWithInsert),
            
            imageAndTextToVideoBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageAndTextToVideoBtn.topAnchor.constraint(equalTo: letsCreateTitle.bottomAnchor, constant: 12),
            imageAndTextToVideoBtn.widthAnchor.constraint(equalToConstant: widthWithInsert),
            
            templatesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            templatesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            templatesCollectionView.topAnchor.constraint(equalTo: imageAndTextToVideoBtn.bottomAnchor, constant: 12),
            templatesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        presenter?.startLoadData()
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(36))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        layoutSectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        return layoutSectionHeader
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch section {
            default : return self?.createSection()
            }
        }
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(widthWithInsert + 16),
                                               heightDimension: .absolute(254))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 20, trailing: 16)
        
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    //MARK: - View elements
    private lazy var navBar = ComponentBuilder.getCustomNavigationBar(title: "Hailuo")
    
    private lazy var textToVideoBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtnForCreate(text: "Text to video", isDark: true, textColor: .accentSecondaryDark)
        btn.addAction(textToVideoAction, for: .touchUpInside)
        DispatchQueue.main.async {
            btn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
        }
        return btn
    }()
    
    private lazy var imageAndTextToVideoBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtnForCreate(text: "Image&text to video", isDark: false, textColor: .accentSecondary)
        btn.addAction(imageAndTextToVideoAction, for: .touchUpInside)
        btn.backgroundColor = .backgroundTertiary
        return btn
    }()
    
    private lazy var letsCreateTitle = ComponentBuilder.getTitleForCreate(text: "Let’s start creating")
    
    //Тут я не знаю точно, как должно все скролиться из-за этого делал вначале так. Чтобы скролилась и коллекция и 2 верхние кнопки Let’s start creating.
//    private lazy var contentView: UIView = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        
//        $0.addSubview(templatesCollectionView)
//        
//        NSLayoutConstraint.activate([
//            templatesCollectionView.topAnchor.constraint(equalTo: $0.topAnchor),
//            templatesCollectionView.leadingAnchor.constraint(equalTo: $0.leadingAnchor),
//            templatesCollectionView.trailingAnchor.constraint(equalTo: $0.trailingAnchor),
//            templatesCollectionView.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -12),
//            templatesCollectionView.heightAnchor.constraint(equalToConstant: 800)
//        ])
//        
//        return $0
//    }(UIView())
//    
//    private lazy var scrollView: UIScrollView = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.backgroundColor = .clear
//        
//        $0.addSubview(contentView)
//        
//        NSLayoutConstraint.activate([
//            contentView.leadingAnchor.constraint(equalTo: $0.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: $0.trailingAnchor),
//            contentView.topAnchor.constraint(equalTo: $0.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: $0.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: $0.widthAnchor)
//        ])
//        
//        return $0
//    }(UIScrollView())
    
    private lazy var templatesCollectionView: UICollectionView = {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(TemplatesCell.self, forCellWithReuseIdentifier: TemplatesCell.reuseId)
        $0.register(TemplatesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TemplatesHeader.reuseId)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: createLayout()))
    
    //MARK: - Actions
    private lazy var textToVideoAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.textToVideoBtn.clickAnimate()
        self.presenter?.goToTextToVideo()
    }
    
    private lazy var imageAndTextToVideoAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.imageAndTextToVideoBtn.clickAnimate()
        self.presenter?.goToImgAndTextToVideo()
    }
    
}

extension CreateView: CreateViewProtocol {
    func showErrorLoad(_ errorText: String) {
        let alertAction = UIAlertController(title: "Network error!", message: errorText, preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .default)
        let tryAgainBtn = UIAlertAction(title: "Try Again", style: .cancel) { [weak self] _ in
//            self.presenter?.saveBtnTaped()
            self?.presenter?.startLoadData()
        }
        alertAction.addAction(cancelBtn)
        alertAction.addAction(tryAgainBtn)
        self.present(alertAction, animated: true)
    }
    
    func finishLoadData(_ model: [TemplatesModel]) {
        allEffects = model
        popularEffects = allEffects.filter({ $0.category == "Trending" })
        templatesCollectionView.reloadData()
    }
    
    func tapToSeeAllBtn(_ numberOfSection: Int) {
        switch numberOfSection {
        case 0:
            presenter?.goToSeeAll(popularEffects)
        default:
            presenter?.goToSeeAll(allEffects)
        }
    }
    
    func showInformations() {
        settupView()
    }
}

extension CreateView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0 :
            presenter?.selectItemInCollection(model: popularEffects[indexPath.item])
        default:
            presenter?.selectItemInCollection(model: allEffects[indexPath.item])
        }
        
    }
}

extension CreateView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return popularEffects.count
        } else {
            return allEffects.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplatesCell.reuseId, for: indexPath) as? TemplatesCell else {
            return UICollectionViewCell()
        }
        if indexPath.section == 0 {
            cell.configureCell(popularEffects[indexPath.item])
        } else {
            cell.configureCell(allEffects[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TemplatesHeader.reuseId, for: indexPath) as? TemplatesHeader else { return UICollectionReusableView() }
        header.sectionNumber = indexPath.section
        header.delegare = self
        if indexPath.section == 0 {
            header.configureHeader(title: "Popular effects")
        } else {
            header.configureHeader(title: "All effects")
        }
        return header
    }
    
}
