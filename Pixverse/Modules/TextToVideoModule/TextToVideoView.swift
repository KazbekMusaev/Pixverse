//
//  TextToVideoView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol TextToVideoViewProtocol: AnyObject {
    func showInformation()
    func showCreatingAnimations()
    func stopCreatingAnimations()
}

final class TextToVideoView: UIViewController {

    var presenter: TextToVideoPresenterProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settupView()
    }
    
    deinit {
        presenter?.touchToPopVCBtn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(navBar)
        view.addSubview(createBtn)
        view.addSubview(textView)
        view.addSubview(clearBtn)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            
            createBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            clearBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            clearBtn.topAnchor.constraint(equalTo: navBar.topAnchor, constant: (view.frame.height / 2) + 12)
        ])
        addDoneButtonToKeyboard()
    }
    
    func addDoneButtonToKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        textView.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    //MARK: - Actions
    private lazy var popVCAction = UIAction { [weak self] _ in
        guard let self else { return }
        presenter?.touchToPopVCBtn()
    }
    
    private lazy var createAction = UIAction { [weak self] _ in
        guard let self, let text = textView.text else { return }
        self.createBtn.clickAnimate()
        self.presenter?.startCreateVideo(prompt: text)
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
    
}

extension TextToVideoView: TextToVideoViewProtocol {
    
    func stopCreatingAnimations() {
        creatingLoadView.removeFromSuperview()
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

extension TextToVideoView: UITextViewDelegate {
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
            self?.createBtn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
            self?.createBtn.isEnabled = true
            self?.createLabel.textColor = .accentSecondaryDark
        }
        
    }
}
