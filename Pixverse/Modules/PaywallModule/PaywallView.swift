//
//  PaywallView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 03.07.2025.
//

import UIKit

protocol PaywallViewProtocol: AnyObject {
    func showInformation()
}

final class PaywallView: UIViewController {
    
    var presenter: PaywallPresenterProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    deinit {
        presenter?.tapToPopVc()
    }
    
    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .backgroundPrimary
        
        view.addSubview(imageView)
        view.addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: (view.frame.height / 2) + 60),
            
            gradientView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 170),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func getDescriptLabel(_ text: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "sparklesWithGradient")
        img.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold) //SF PRO
        label.textColor = .labelSecondary
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = text
        
        view.addSubview(img)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 2),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 6.5),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6.5),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -100),
        ])
        return view
    }
    
    
    //MARK: - View elements
    private lazy var createLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .boldSystemFont(ofSize: 28) // SF PRO
        $0.textColor = .labelPrimary
        $0.text = "Create creative videos"
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(createLabel)
        view.addSubview(proDescriptionView)
        
        NSLayoutConstraint.activate([
            createLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            createLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            proDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            proDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            proDescriptionView.topAnchor.constraint(equalTo: createLabel.bottomAnchor, constant: 16),
            proDescriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
        DispatchQueue.main.async {
            view.createGradientBackground(colors: [UIColor.clear.cgColor, UIColor.backgroundPrimary.withAlphaComponent(0.5).cgColor, UIColor.backgroundPrimary.cgColor])
        }
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(resource: .paywallImg)
        return $0
    }(UIImageView())
    
    private lazy var proDescriptionView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        stackView.addArrangedSubview(getDescriptLabel("Access to all effects"))
        stackView.addArrangedSubview(getDescriptLabel("Unlimited generation"))
        stackView.addArrangedSubview(getDescriptLabel("Access to all functions"))
        
        $0.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: $0.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -16)
        ])
        
        return $0
    }(UIView())
    
    //MARK: - Actions
    
}


extension PaywallView: PaywallViewProtocol {
    func showInformation() {
        settupView()
    }
    
    
}
