//
//  TemplatesHeader.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

final class TemplatesHeader: UICollectionReusableView {
    
    weak var delegare: CreateViewProtocol?
    var sectionNumber: Int?
    
    static let reuseId = "TemplatesHeader"
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        settupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View elements
    private lazy var headerLabel = ComponentBuilder.getTitleForCreate()
    
    private lazy var seeAllBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 8
        
        let seeAllLabel = UILabel()
        seeAllLabel.translatesAutoresizingMaskIntoConstraints = false
        seeAllLabel.font = .systemFont(ofSize: 13) // SF PRO
        seeAllLabel.textColor = .labelPrimary
        seeAllLabel.text = "See all"
        
        let chevron = UIImageView()
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.contentMode = .scaleAspectFit
        chevron.heightAnchor.constraint(equalToConstant: 18).isActive = true
        chevron.widthAnchor.constraint(equalToConstant: 18).isActive = true
        chevron.image = UIImage(systemName: "chevron.right")
        chevron.tintColor = .labelPrimary
        
        $0.addSubview(seeAllLabel)
        $0.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            seeAllLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 12),
            seeAllLabel.topAnchor.constraint(equalTo: $0.topAnchor),
            seeAllLabel.bottomAnchor.constraint(equalTo: $0.bottomAnchor),
            
            chevron.centerYAnchor.constraint(equalTo: $0.centerYAnchor),
            chevron.leadingAnchor.constraint(equalTo: seeAllLabel.trailingAnchor),
        ])
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.separatorSecondary.cgColor
        $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        return $0
    }(UIButton(primaryAction: seeAllAction))
    
    //MARK: Functions
    private func settupHeader() {
        backgroundColor = .clear
        addSubview(headerLabel)
        addSubview(seeAllBtn)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            seeAllBtn.trailingAnchor.constraint(equalTo: trailingAnchor),
            seeAllBtn.topAnchor.constraint(equalTo: topAnchor),
            seeAllBtn.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureHeader(title: String) {
        headerLabel.text = title
    }
    
    //MARK: - Action
    private lazy var seeAllAction = UIAction { [weak self] _ in
        guard let self, let sectionNumber else { return }
        self.seeAllBtn.clickAnimate()
        self.delegare?.tapToSeeAllBtn(sectionNumber)
    }
}
