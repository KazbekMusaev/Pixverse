//
//  MineVideoCell.swift
//  Pixverse
//
//  Created by KazbekMusaev on 02.07.2025.
//

import UIKit

final class MineVideoCell: UICollectionViewCell {
    
    static let reuseId = "MineVideoCell"
    var model: VideoModel?
    weak var delegate: MineViewProtocol?
    private var isFavorite: Bool = false
    
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
        isUserInteractionEnabled = true
        layer.cornerRadius = 8
        clipsToBounds = true
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        addSubview(isFavoriteBtn)
        
        NSLayoutConstraint.activate([
            isFavoriteBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            isFavoriteBtn.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        ])
    }
    
    func configireCell(model: VideoModel) {
        guard let pathToFiles = model.pathToFiles else { return }
        self.model = model
        VideoLoader.addVideoPlayer(to: self, filename: pathToFiles + ".mp4")
        if model.favorite {
            pinImage.image = UIImage(systemName: "bookmark.fill")
            isFavorite = model.favorite
        }
    }
    
    
    //MARK: - Actions
    private lazy var favoriteBtnAction = UIAction { [weak self] _ in
        guard let self, let model else { return }
        self.isFavoriteBtn.clickAnimate()
        guard let index = CoreManager.shared.posts.firstIndex(where: { $0.id == model.id }) else { return }
        isFavorite.toggle()
        if isFavorite {
            self.pinImage.image = UIImage(systemName: "bookmark.fill")
        } else {
            self.pinImage.image = UIImage(systemName: "bookmark")

        }
        CoreManager.shared.posts[index].updateData(pathToVideo: nil, status: nil, favorite: isFavorite)
        delegate?.reloadFavorite()
    }
    
    //MARK: - View elements
    private lazy var isFavoriteBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 44).isActive = true
        $0.layer.cornerRadius = 8
        $0.layer.zPosition = 1
        $0.isUserInteractionEnabled = true
        $0.isEnabled = true
        $0.backgroundColor = .ultraThinMaterial
        $0.addSubview(pinImage)
        
        NSLayoutConstraint.activate([
            pinImage.centerXAnchor.constraint(equalTo: $0.centerXAnchor),
            pinImage.centerYAnchor.constraint(equalTo: $0.centerYAnchor)
        ])
        
        return $0
    }(UIButton(primaryAction: favoriteBtnAction))
    
    private lazy var pinImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "bookmark")
        $0.tintColor = .labelPrimary
        return $0
    }(UIImageView())
    
}
