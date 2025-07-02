//
//  LaunchScreenView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 02.07.2025.
//

import UIKit

protocol LaunchScreenViewControllerProtocol: AnyObject {
    func showPages()
    func tapToNextBtn()
}

final class LaunchScreenViewController: UIViewController {

    let pages = LoadScreenModel.getData()
    var presenter: LoadScreenPresenterProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        view.addSubview(imageView)
        view.addSubview(headersLabel)
        view.addSubview(pageControl)
        view.addSubview(nextBtn)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -260),
            
            headersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headersLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 42),
            
            nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: -12),
        ])
        configurePage(pages[0])
    }
    
    func configurePage(_ page: LoadScreenModel) {
        imageView.image = UIImage(named: page.img)
        headersLabel.text = page.header
    }
    
    //MARK: - View elements
    private lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    

    
    private lazy var headersLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .boldSystemFont(ofSize: 34) //SF PRO
        $0.textColor = .labelPrimary
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var pageControl: UIPageControl = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfPages = pages.count
        $0.currentPage = 0
        $0.addAction(changePageAction, for: .valueChanged)
        return $0
    }(UIPageControl())
    
    private lazy var nextBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtn(action: nextAction, text: "Next")
        DispatchQueue.main.async {
            btn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
        }
        return btn
    }()
    
    //MARK: - Actions
    private lazy var nextAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.nextBtn.clickAnimate()
        tapToNextBtn()
    }
    
    private lazy var changePageAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.configurePage(self.pages[pageControl.currentPage])
    }
}

extension LaunchScreenViewController: LaunchScreenViewControllerProtocol {
    func tapToNextBtn() {
        let currentPage = pageControl.currentPage + 1
        if currentPage != pages.count {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self else { return }
                self.configurePage(self.pages[pageControl.currentPage + 1])
                self.pageControl.currentPage += 1
            }
        } else {
            presenter?.goToMainScreen()
        }
    }
    
    func showPages() {
        settupView()
    }
    
    
}
