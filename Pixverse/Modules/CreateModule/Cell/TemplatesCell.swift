//
//  TemplatesCell.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit
import GSPlayer

final class TemplatesCell: UICollectionViewCell {
    
    static let reuseId = "TemplatesCell"
    private var currentTaskID: UUID?
    
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
    
    func configureCell(_ model: TemplatesModel) {
        templateNameLabel.text = model.name
        
        if let url = URL(string: model.previewSmall) {
            previewImg.play(for: url)
            previewImg.pause(reason: .userInteraction)
            indicator.removeFromSuperview()
        }
        
//        if let taskID = currentTaskID {
//            VideoLoader.cancelTask(taskID)
//        }
//        
//        if let url = URL(string: model.previewSmall) {
//            currentTaskID = VideoLoader.loadThumbnail(for: url) { [weak self] image in
//                self?.previewImg.image = image
//                self?.indicator.stopAnimating()
//                self?.indicator.removeFromSuperview()
//            }
//        }
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        previewImg.image = nil
//        if let taskID = currentTaskID {
//            VideoLoader.cancelTask(taskID)
//        }
    }
    
    //MARK: - View elements
    private lazy var previewImg: VideoPlayerView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        
        $0.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: $0.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: $0.centerYAnchor)
        ])
        
        return $0
    }(VideoPlayerView())
    
    private lazy var templateNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .labelPrimary
        return $0
    }(UILabel())
    
    private lazy var indicator = UIActivityIndicatorView.getIndicator()
    
}
