//
//  ImgAndTextToVideoView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol ImgAndTextToVideoViewProtocol: AnyObject {
    func showInformation()
    func showCreatingAnimations()
    func showImagePicker(mediaType: MediaType)
    func stopCreatingAnimations()
}

final class ImgAndTextToVideoView: UIViewController {

    private lazy var imagePicker = ImagePickerManager(viewController: self) { [weak self] image in
        guard let self, let image else { return }
        self.selectedImage = image
        self.image.image = image
        self.image.isHidden = false
        self.deleteImageBtn.isHidden = false
        
        if let text = textView.text {
            if !text.isEmpty {
                UIView.animate(withDuration: 0.5) {
                    self.createBtn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
                    self.createBtn.isEnabled = true
                    self.createLabel.textColor = .accentSecondaryDark
                }
            }
        }
    }
    
    var presenter: ImgAndTextToVideoPresenterProtocol?
    var selectedImage: UIImage?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    deinit {
        presenter?.touchToPopVCBtn()
    }

    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(navBar)
        view.addSubview(selectedImageView)
        view.addSubview(textView)
        view.addSubview(clearBtn)
        view.addSubview(createBtn)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            selectedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            selectedImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            selectedImageView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 16),
            selectedImageView.heightAnchor.constraint(equalToConstant: 200),
            
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: 12),
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            
            createBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            clearBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            clearBtn.topAnchor.constraint(equalTo: navBar.topAnchor, constant: 430)
        ])
    }
    
    //MARK: - View elements
    private lazy var creatingLoadView = CreatingVideoAnimateView()
    private lazy var navBar = ComponentBuilder.getCustomEmptyNavigationBar(title: "Create", action: popVCAction)
    
    private lazy var createBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtnForChangeLabel(action: createAction, label: createLabel)
        btn.isEnabled = false
        btn.backgroundColor = .accentGrey
        return btn
    }()
    
    private lazy var createLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Create"
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 17) // SF PRO
        $0.textColor = .labelQuintuple
        return $0
    }(UILabel())
    
    private lazy var textView: UITextView =  {
        let text = ComponentBuilder.getTextView(delegate: self)

        text.addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: text.leadingAnchor, constant: 20),
            placeholderLabel.topAnchor.constraint(equalTo: text.topAnchor, constant: 16),
            placeholderLabel.trailingAnchor.constraint(equalTo: text.trailingAnchor, constant: -20),
        ])
        
        
        return text
    }()
    
    private lazy var clearBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false

        $0.layer.cornerRadius = 22
        $0.setImage(UIImage(systemName: "trash"), for: .normal)
        $0.tintColor = .labelPrimary
        $0.backgroundColor = .ultraThinMaterial
        $0.isHidden = true
        
        return $0
    }(UIButton(primaryAction: clearAction))
    
    private lazy var deleteImageBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false

        $0.layer.cornerRadius = 22
        $0.setImage(UIImage(systemName: "trash"), for: .normal)
        $0.tintColor = .labelPrimary
        $0.backgroundColor = .ultraThinMaterial
        $0.isHidden = true
        
        return $0
    }(UIButton(primaryAction: deletePhotoAction))
    
    private lazy var placeholderLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 17) // SF PRO
        $0.textColor = .labelQuaternary
        $0.numberOfLines = 0
        $0.text = """
                    Enter any query to create your video 
                    using AI
                    """
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var selectedImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            view.addDashedBorder(color: .separatorPrimary)
        }
        
        view.addSubview(addImageBtn)
        view.addSubview(image)
        view.addSubview(deleteImageBtn)
        
        NSLayoutConstraint.activate([
            addImageBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addImageBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            deleteImageBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteImageBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        return view
    }()
    
    private lazy var addImageBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Add image", for: .normal)
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .labelQuaternary
        return $0
    }(UIButton(primaryAction: addPhotoAction))
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isHidden = true
        
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.separatorPrimary.cgColor
        
        return $0
    }(UIImageView())
    
    //MARK: - Actions
    private lazy var popVCAction = UIAction { [weak self] _ in
        guard let self else { return }
        presenter?.touchToPopVCBtn()
    }

    private lazy var createAction = UIAction { [weak self] _ in
        guard let self, let selectedImage, let prompt = textView.text else { return }
        guard let data = selectedImage.jpegData(compressionQuality: 0.2) else { return }
        self.createBtn.clickAnimate()
        self.presenter?.createBtnTaped(prompt: prompt, image: data)
    }
    
    private lazy var clearAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.clearBtn.clickAnimate()
        UIView.animate(withDuration: 0.5) {
            self.view.endEditing(true)
            self.textView.text = ""
            self.placeholderLabel.isHidden = false
            self.clearBtn.isHidden = true
        }
    }
    
    private lazy var deletePhotoAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.deleteImageBtn.clickAnimate()
        UIView.animate(withDuration: 0.5) {
            self.image.isHidden = true
            self.image.image = nil
            self.selectedImage = nil
            self.deleteImageBtn.isHidden = true
            self.createBtn.isEnabled = false
            self.createBtn.layer.sublayers?.filter { $0.name == "gradientLayer" }.forEach { $0.removeFromSuperlayer() }
            self.createLabel.textColor = .labelQuintuple
        }
    }
    
    private lazy var addPhotoAction = UIAction { [weak self] _ in
        guard let self else { return }
        presenter?.addPhotoTaped()
    }
    
}

extension ImgAndTextToVideoView: ImgAndTextToVideoViewProtocol {
    
    func stopCreatingAnimations() {
        creatingLoadView.removeFromSuperview()
    }
    
    func showImagePicker(mediaType: MediaType) {
        switch mediaType {
        case .camera:
            imagePicker.openCamera()
        case .gallery:
            imagePicker.openGallery()
        }
    }
    
    func showInformation() {
        settupView()
    }
    
    func showCreatingAnimations() {
        
        creatingLoadView.action = { [weak self] in
            self?.presenter?.touchToPopVCBtn()
        }
        
        creatingLoadView.settupView()
        
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self else { return }
            self.view.addSubview(self.creatingLoadView)
            
            NSLayoutConstraint.activate([
                self.creatingLoadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.creatingLoadView.topAnchor.constraint(equalTo: view.topAnchor),
                self.creatingLoadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.creatingLoadView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
    }
}

extension ImgAndTextToVideoView: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard let text = textView.text, !text.isEmpty else {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.placeholderLabel.isHidden = false
                self?.clearBtn.isHidden = true
                self?.createBtn.isEnabled = false
                self?.createBtn.layer.sublayers?.filter { $0.name == "gradientLayer" }.forEach { $0.removeFromSuperlayer() }
                self?.createLabel.textColor = .labelQuintuple
            }
            return
        }
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.placeholderLabel.isHidden = true
            self?.clearBtn.isHidden = false
        }
        if selectedImage != nil {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.createBtn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
                self?.createBtn.isEnabled = true
                self?.createLabel.textColor = .accentSecondaryDark
            }
        }
        
    }
}
