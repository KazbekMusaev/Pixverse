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
}

final class TemplatesResultView: UIViewController {

    var presenter: TemplatesResultPresenterProtocol?
    var videoURL: String?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
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
            videoPlayerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    //MARK: - View elements
    private lazy var navBar: UIView = {
        let view = ComponentBuilder.getCustomEmptyNavigationBar(title: "Result", action: popVCAction)
        
        let moreActionBtn = UIButton()
        moreActionBtn.translatesAutoresizingMaskIntoConstraints = false
        moreActionBtn.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        moreActionBtn.tintColor = .accentPrimary
        moreActionBtn.addTarget(self, action: #selector(showMenu(_:)), for: .touchUpInside)
        
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
        return btn
    }()
    
    //MARK: - Actions
    private lazy var saveAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.saveBtn.clickAnimate()
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
    
    @objc func showMenu(_ sender: UIButton) {
        let items = [
            EditMenuItem(title: "Share", image: UIImage(systemName: "pencil")) {
                print("Редактировать tapped")
            },
            EditMenuItem(title: "Save to files", image: UIImage(systemName: "square.and.arrow.up")) {
                print("Поделиться tapped")
            },
            EditMenuItem(title: "Delete", image: UIImage(systemName: "trash"), action: {
                print("Удалить tapped")
            }, isDestructive: true)
        ]
        
        showEditMenu(for: sender, items: items)
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
    func showInformation() {
        settupView()
    }
    
    
}
