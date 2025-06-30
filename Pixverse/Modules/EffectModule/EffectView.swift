//
//  EffectView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit
import GSPlayer

protocol EffectViewProtocol: AnyObject {
    func showInforamtion()
}

final class EffectView: UIViewController {
    
    var presenter: EffectPresenterProtocol?
    var model: TemplatesModel?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    deinit {
        TabBarManager.shared.show()
    }
    
    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(navBar)
        view.addSubview(videoPlayerView)
        view.addSubview(continueBtn)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            videoPlayerView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 40),
            videoPlayerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            
            continueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
//    private func setupVideoPlayer() {
//        guard let model = model, let url = URL(string: model.previewLarge) else { return }
//        
//        
//        
////        videoPlayerView.stateDidChanged = { [weak self] state in
////            guard let self = self else { return }
////            
////            switch state {
////            case .playing:
////                self.isPlaying = true
////                self.playBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
////            case .paused:
////                self.isPlaying = false
////                self.playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
////            default:
////                break
////            }
////        }
//    }
    
    //MARK: - View elements
    private lazy var navBar = ComponentBuilder.getCustomEmptyNavigationBar(title: model?.name ?? "", action: popVCAction)
    
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
        
        if let model, let url = URL(string: model.previewLarge) {
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
    
    private lazy var continueBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtn(action: continueAction, text: "Continue")
        DispatchQueue.main.async {
            btn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
        }
        return btn
    }()
    
    
    
    //MARK: - Actions
    private lazy var continueAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.continueBtn.clickAnimate()
        self.presenter?.touchToContinueBtn()
    }
    
    private lazy var popVCAction = UIAction { [weak self] _ in
        self?.presenter?.touchToPopVCBtn()
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

extension EffectView: EffectViewProtocol {
    func showInforamtion() {
        settupView()
    }
}
