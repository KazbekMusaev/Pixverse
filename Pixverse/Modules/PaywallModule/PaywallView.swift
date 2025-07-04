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
    
    private var selectedPrice: Period = .week
    
    private let saleModel: [PriceModel] = [
        PriceModel(period: .year, price: 19, onSale: true, discountPersent: 40),
        PriceModel(period: .week, price: 19, onSale: false, discountPersent: 0),
    ]
    
    
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
        view.addSubview(exitBtn)
        view.addSubview(gradientView)
        view.addSubview(yearBtn)
        view.addSubview(weekBtn)
        view.addSubview(continueBtn)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: (view.frame.height / 2) + 60),
            
            exitBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            exitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            gradientView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 170),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            yearBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            yearBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            yearBtn.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: 28),
            
            weekBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weekBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            weekBtn.topAnchor.constraint(equalTo: yearBtn.bottomAnchor, constant: 16),
            
            continueBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            continueBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.exitBtn.isHidden = false
        }
        
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
            label.leadingAnchor.constraint(lessThanOrEqualTo: img.trailingAnchor, constant: 2),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 6.5),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6.5),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
        ])
        return view
    }
    
    private func changePrice() {
        switch selectedPrice {
        case .year:
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self else { return }
                self.yearBtn.layer.borderColor = UIColor.accentPrimary.cgColor
                DispatchQueue.main.async {
                    self.yearBtn.addHorizontalGradient(colors: [.accentPrimaryAlpha, .accentPrimary.withAlphaComponent(0.25)])
                }
                self.yearImgView.image = UIImage(systemName: "circle.fill")
                self.yearImgView.tintColor = .accentPrimary
                
                
                self.weekBtn.layer.borderColor = UIColor.separatorPrimary.cgColor
                self.weekBtn.layer.sublayers?.filter { $0.name == "gradientLayer" }.forEach { $0.removeFromSuperlayer() }
                self.weekImgView.image = UIImage(systemName: "circle")
                self.weekImgView.tintColor = .labelQuaternary
            }
        case .week:
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self else { return }
                self.weekBtn.layer.borderColor = UIColor.accentPrimary.cgColor
                DispatchQueue.main.async {
                    self.weekBtn.addHorizontalGradient(colors: [.accentPrimaryAlpha, .accentPrimary.withAlphaComponent(0.25)])
                }
                self.weekImgView.image = UIImage(systemName: "circle.fill")
                self.weekImgView.tintColor = .accentPrimary
                
                
                self.yearBtn.layer.borderColor = UIColor.separatorPrimary.cgColor
                self.yearBtn.layer.sublayers?.filter { $0.name == "gradientLayer" }.forEach { $0.removeFromSuperlayer() }
                self.yearImgView.image = UIImage(systemName: "circle")
                self.yearImgView.tintColor = .labelQuaternary
            }
        }
    }
    
    //MARK: - View elements
    private lazy var continueBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtn(action: continueAction, text: "Continue")
        DispatchQueue.main.async {
            btn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
        }
        return btn
    }()
    
    
    private lazy var exitBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .labelTertiary
        $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 24).isActive = true
        $0.isHidden = true
        return $0
    }(UIButton(primaryAction: exitAction))
    
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
    
    private lazy var yearBtn: UIButton = {
        let btn = ComponentBuilder.getPaywallPricesBtn(model: saleModel[0], imageView: yearImgView)
        btn.addAction(yearAction, for: .touchUpInside)
        return btn
    }()
    
    private lazy var weekBtn: UIButton = {
        let btn = ComponentBuilder.getPaywallPricesBtn(model: saleModel[1], imageView: weekImgView)
        btn.layer.borderColor = UIColor.accentPrimary.cgColor
        
        DispatchQueue.main.async {
            btn.addHorizontalGradient(colors: [.accentPrimaryAlpha, .accentPrimary.withAlphaComponent(0.25)])
        }
        btn.addAction(weekAction, for: .touchUpInside)
        return btn
    }()
    
    private lazy var yearImgView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "circle")
        $0.tintColor = .labelQuaternary
        return $0
    }(UIImageView())
    
    private lazy var weekImgView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "circle.fill")
        $0.tintColor = .accentPrimary
        return $0
    }(UIImageView())
        
    //MARK: - Actions
    private lazy var continueAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.continueBtn.clickAnimate()
    }
    
    private lazy var exitAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.presenter?.tapToPopVc()
    }
    
    private lazy var yearAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.yearBtn.clickAnimate()
        self.selectedPrice = .year
        self.changePrice()
    }
    
    private lazy var weekAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.weekBtn.clickAnimate()
        self.selectedPrice = .week
        self.changePrice()
    }
}


extension PaywallView: PaywallViewProtocol {
    func showInformation() {
        settupView()
    }
    
    
}
