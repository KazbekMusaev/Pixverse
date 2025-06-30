//
//  AddPhotoHelperView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

final class AddPhotoHelperView: UIViewController {

    weak var delegate: EffectViewProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settupView()
    }
    
    //MARK: - Functions
    private func settupView() {
        view.addDarkBlurEffect()
        view.addSubview(addPhotoLabel)
        view.addSubview(badExample)
        view.addSubview(badPhotoDescription)
        view.addSubview(badPhotoStackView)
        view.addSubview(goodExample)
        view.addSubview(goodPhotoDescription)
        view.addSubview(goodPhotoStackView)
        view.addSubview(takeAPhotoBtn)
        view.addSubview(fromTheGalleryBtn)
        view.addSubview(decriptionLabel)
        
        NSLayoutConstraint.activate([
            addPhotoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            addPhotoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addPhotoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            badExample.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            badExample.topAnchor.constraint(equalTo: addPhotoLabel.bottomAnchor, constant: 28),
            
            badPhotoDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            badPhotoDescription.topAnchor.constraint(equalTo: badExample.bottomAnchor, constant: 6),
            badPhotoDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            badPhotoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            badPhotoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            badPhotoStackView.topAnchor.constraint(equalTo: badPhotoDescription.bottomAnchor, constant: 16),
            
            goodExample.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            goodExample.topAnchor.constraint(equalTo: badPhotoStackView.bottomAnchor, constant: 12),
            
            goodPhotoDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            goodPhotoDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            goodPhotoDescription.topAnchor.constraint(equalTo: goodExample.bottomAnchor, constant: 6),
            
            goodPhotoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            goodPhotoStackView.topAnchor.constraint(equalTo: goodPhotoDescription.bottomAnchor, constant: 16),
            goodPhotoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            takeAPhotoBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            takeAPhotoBtn.topAnchor.constraint(equalTo: goodPhotoStackView.bottomAnchor, constant: 20),
            takeAPhotoBtn.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 2),
            
            fromTheGalleryBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            fromTheGalleryBtn.topAnchor.constraint(equalTo: goodPhotoStackView.bottomAnchor, constant: 20),
            fromTheGalleryBtn.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 2),
            
            decriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            decriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            decriptionLabel.topAnchor.constraint(equalTo: fromTheGalleryBtn.bottomAnchor, constant: 8)
            
        ])
    }
    
    private func getPhotoView(name: String) -> UIImageView {
        let imgView = UIImageView()
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        imgView.image = UIImage(named: name)
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 12
        imgView.clipsToBounds = true
        
        imgView.widthAnchor.constraint(equalToConstant: (view.frame.width - 43) / 2).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: (view.frame.width - 43) / 2).isActive = true
        return imgView
    }
    
    private func getLabel(text: String, font: UIFont, numberOfLine: Int, textColor: UIColor = .labelPrimary, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font // SF PRO
        label.numberOfLines = numberOfLine
        label.textColor = textColor
        label.textAlignment = alignment
        return label
    }
    
    //MARK: - View elements
    private lazy var addPhotoLabel = getLabel(text: "Add photo", font: .systemFont(ofSize: 20), numberOfLine: 1,alignment: .center)
    private lazy var badExample = getLabel(text: "Bad examples", font: .systemFont(ofSize: 20), numberOfLine: 1, alignment: .left)
    private lazy var badPhotoDescription = getLabel(text: "Group photo, covered face, nudity, very large face, blurred face, very small face, hands not visible or covered.", font: .systemFont(ofSize: 13), numberOfLine: 2, alignment: .left)
    
    private lazy var badPhotoStackView: UIStackView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 11
        
        let badPhotoOne = getPhotoView(name: "badExample1")
        let badPhotoTwo = getPhotoView(name: "badExample2")
        
        $0.addArrangedSubview(badPhotoOne)
        $0.addArrangedSubview(badPhotoTwo)
        
        return $0
    }(UIStackView())
    
    private lazy var goodExample = getLabel(text: "Good examples", font: .systemFont(ofSize: 20), numberOfLine: 1, alignment: .left)
    private lazy var goodPhotoDescription = getLabel(text: "The photo was taken full-face (the man is standing straight), hands are visible.", font: .systemFont(ofSize: 13), numberOfLine: 2, alignment: .left)
    
    private lazy var goodPhotoStackView: UIStackView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 11
        
        let goodPhotoOne = getPhotoView(name: "goodExample1")
        let goodPhotoTwo = getPhotoView(name: "goodExample2")
        
        $0.addArrangedSubview(goodPhotoOne)
        $0.addArrangedSubview(goodPhotoTwo)
        
        return $0
    }(UIStackView())
    
    private lazy var takeAPhotoBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtn(action: takeAPhotoAction, text: "Take a photo", textColor: .labelPrimary)
        btn.backgroundColor = .accentPrimaryAlpha
        return btn
    }()
    
    private lazy var fromTheGalleryBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtn(action: fromTheGalleryAction, text: "From the gallery", textColor: .accentSecondaryDark)
//        btn.backgroundColor = .accentSecondary
        //Тут не ставится градиент, потом вернусь к этому
        DispatchQueue.main.async {
            btn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
        }
        return btn
    }()
    
    private lazy var decriptionLabel = getLabel(text: "Use images where the face and hands are visible for the best result.", font: .systemFont(ofSize: 11, weight: .semibold), numberOfLine: 2, textColor: .labelPrimary, alignment: .center)
    
    //MARK: - Actions
    private lazy var takeAPhotoAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.takeAPhotoBtn.clickAnimate()
    }
    
    private lazy var fromTheGalleryAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.fromTheGalleryBtn.clickAnimate()
    }

}
