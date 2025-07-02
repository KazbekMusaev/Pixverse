//
//  TempatesResultView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit
import GSPlayer

protocol TemplatesResultViewProtocol: AnyObject {
    func showInformation()
    
    func showSuccesSaveAllert()
    func showErrorSaveAlert()
}

final class TemplatesResultView: UIViewController {

    var presenter: TemplatesResultPresenterProtocol?
    var videoURL: String?
    
    var prompt: String?
    var fileName: String?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    deinit {
        presenter?.touchToPopVCBtn()
    }

    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(navBar)
        view.addSubview(videoPlayerView)
        view.addSubview(saveBtn)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            videoPlayerView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 40),
            videoPlayerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    private func settupWithPrompt() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 12),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
        ])
    }
    
    private func settupDownloadIsDocument() {
        guard let fileName, let filePath = FileManagerService.getFileURL(fileName: fileName + ".mp4") else { return }
        videoPlayerView.play(for: filePath)
    }
    
    //MARK: - View elements
    private lazy var navBar: UIView = {
        let view = ComponentBuilder.getCustomEmptyNavigationBar(title: "Result", action: popVCAction)
        
        let moreActionBtn = UIButton()
        moreActionBtn.translatesAutoresizingMaskIntoConstraints = false
        moreActionBtn.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        moreActionBtn.tintColor = .accentPrimary
        moreActionBtn.layer.cornerRadius = 12
        
        moreActionBtn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        let interaction = UIContextMenuInteraction(delegate: self)
        moreActionBtn.addInteraction(interaction)
        
        view.addSubview(moreActionBtn)
        NSLayoutConstraint.activate([
            moreActionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            moreActionBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            moreActionBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
        ])
        
        return view
    }()
    
    private lazy var videoPlayerView: VideoPlayerView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.contentMode = .scaleAspectFill
        $0.addGestureRecognizer(tapGesture)
        
        $0.addSubview(playBtn)
        
        NSLayoutConstraint.activate([
            playBtn.centerXAnchor.constraint(equalTo: $0.centerXAnchor),
            playBtn.centerYAnchor.constraint(equalTo: $0.centerYAnchor),
        ])
        
        if let videoURL, let url = URL(string: videoURL) {
            $0.play(for: url)
            $0.pause(reason: .userInteraction)
            playBtn.isHidden = false
        }
        
        return $0
    }(VideoPlayerView())

    private lazy var playBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "play.fill"), for: .normal)
        $0.heightAnchor.constraint(equalToConstant: 76).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 76).isActive = true
        $0.layer.cornerRadius = 38
        $0.backgroundColor = .ultraThinMaterial
        $0.tintColor = .labelPrimary
        $0.isHidden = true
        return $0
    }(UIButton(primaryAction: togglePlayAction))
    
    private lazy var saveBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtn(action: saveAction, text: "Save")
        DispatchQueue.main.async {
            btn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
        }
        btn.layer.zPosition = 1
        return btn
    }()
    
    private lazy var promptLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Prompt"
        $0.textColor = .labelPrimary
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.font = .boldSystemFont(ofSize: 20) // SF PRO
        return $0
    }(UILabel())
    
    private lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.addSubview(contentToScrollView)
        
        NSLayoutConstraint.activate([
            contentToScrollView.leadingAnchor.constraint(equalTo: $0.leadingAnchor),
            contentToScrollView.topAnchor.constraint(equalTo: $0.topAnchor),
            contentToScrollView.bottomAnchor.constraint(equalTo: $0.bottomAnchor),
            contentToScrollView.trailingAnchor.constraint(equalTo: $0.trailingAnchor),
            contentToScrollView.widthAnchor.constraint(equalTo: $0.widthAnchor)
        ])
        
        return $0
    }(UIScrollView())
    
    private lazy var contentToScrollView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.addSubview(promptLabel)
        $0.addSubview(textView)
        
        NSLayoutConstraint.activate([
            promptLabel.topAnchor.constraint(equalTo: $0.topAnchor, constant: 12),
            promptLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 16),
            
            textView.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 16),
            textView.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -10),
        ])
        
        return $0
    }(UIView())
    
    private lazy var textView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.isSelectable = true
        $0.isScrollEnabled = false
        $0.layer.zPosition = 0
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 17) // SF PRO
        $0.textAlignment = .left
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.textColor = .labelPrimary
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.separatorSecondary.cgColor
        $0.backgroundColor = .clear
        
        return $0
    }(UITextView())
    
    //MARK: - Actions
    private lazy var saveAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.saveBtn.clickAnimate()
        self.presenter?.saveBtnTaped()
    }
    
    private lazy var popVCAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.presenter?.touchToPopVCBtn()
    }
    
    private lazy var togglePlayAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.playBtn.isHidden = false
        self.playBtn.clickAnimate()
        if self.videoPlayerView.state == .playing {
            self.videoPlayerView.pause(reason: .userInteraction)
            self.playBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            self.videoPlayerView.resume()
            self.playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.playBtn.isHidden = true
        }
    }
    
    //MARK: - Gesture
    private lazy var tapGesture: UITapGestureRecognizer = {
        $0.addTarget(self, action: #selector(toggleVideoState(sender: )))
        return $0
    }(UITapGestureRecognizer())
    
    @objc func toggleVideoState(sender: UITapGestureRecognizer) {
        self.playBtn.isHidden = false
        self.playBtn.clickAnimate()
        if self.videoPlayerView.state == .playing {
            self.videoPlayerView.pause(reason: .userInteraction)
            self.playBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            self.videoPlayerView.resume()
            self.playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.playBtn.isHidden = true
        }
    }


}

extension TemplatesResultView: TemplatesResultViewProtocol {
    func showSuccesSaveAllert() {
        let alertAction = UIAlertController(title: "Video saved to gallery", message: nil, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .cancel)
        alertAction.addAction(okBtn)
        self.present(alertAction, animated: true)
    }
    
    func showErrorSaveAlert() {
        let alertAction = UIAlertController(title: "Error, video not saved to gallery?", message: "Something went wrong or the server is not responding. Try again or do it later.", preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .default)
        let tryAgainBtn = UIAlertAction(title: "Try Again", style: .cancel) { _ in
            self.presenter?.saveBtnTaped()
        }
        alertAction.addAction(cancelBtn)
        alertAction.addAction(tryAgainBtn)
        self.present(alertAction, animated: true)
    }
    
    func showInformation() {
        settupView()
        if let prompt {
            textView.text = prompt
            settupWithPrompt()
        }
        if let fileName {
            settupDownloadIsDocument()
        }
    }
    
    
}

extension TemplatesResultView: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { [weak self] _ in
                let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                    self?.presenter?.shareBtnTaped()
                    
                }
                
                let save = UIAction(title: "Save to files", image: UIImage(systemName: "folder.fill.badge.plus")) { _ in
                    self?.presenter?.saveBtnTaped()
                }
                
                let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                    
                    let alertAction = UIAlertController(title: "Delete this video?", message: "It will disappear from the list on the History tab. You will not be able to restore it after deleting it.", preferredStyle: .alert)
                    let yesBtn = UIAlertAction(title: "Cancel", style: .cancel)
                    let cancelBtn = UIAlertAction(title: "Delete", style: .destructive) { _ in
                        self?.presenter?.deleteBtnTaped()
                    }
                    alertAction.addAction(yesBtn)
                    alertAction.addAction(cancelBtn)
                    self?.present(alertAction, animated: true)
                }
                
                return UIMenu(title: "", children: [share, save, delete])
            }
        )
    }
    
    
}
