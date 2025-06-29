//
//  TemplatesCell.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

final class TemplatesCell: UICollectionViewCell {
    
    static let reuseId = "TemplatesCell"
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        settupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    private func settupCell() {
        backgroundColor = .clear
        
        addSubview(previewImg)
        addSubview(templateNameLabel)
        
        NSLayoutConstraint.activate([
            previewImg.topAnchor.constraint(equalTo: topAnchor),
            previewImg.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewImg.trailingAnchor.constraint(equalTo: trailingAnchor),
            previewImg.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            
            templateNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            templateNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            templateNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
        ])
    }
    
    //MARK: - View elements
    private lazy var previewImg: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        
        $0.image = UIImage(named: "testImg")
        
        return $0
    }(UIImageView())
    
    private lazy var templateNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .labelPrimary
        $0.text = "Crumble it"
        return $0
    }(UILabel())
    
}
