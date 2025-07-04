//
//  ComponentBuilder.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

final class ComponentBuilder {
    
    private init() {}
    
    ///Метод для получние навигационной панели.
    ///
    ///Также сюда будет добавлена кнопка "pro"
    static func getCustomNavigationBar(title: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .labelPrimary
        label.font = .boldSystemFont(ofSize: 28) //SF PRO
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = title
        
        let bottomBorder = getDivider()
        
        view.addSubview(label)
        view.addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -240),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            
            bottomBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        return view
    }
    
    ///Метод для получения пустого navBar с кнопкой возврата
    static func getCustomEmptyNavigationBar(title: String, action: UIAction) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background
        view.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .labelPrimary
        label.font = .systemFont(ofSize: 17) //SF PRO
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = title
        
        let btn = UIButton(primaryAction: action)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = .accentPrimary
        
        let bottomBorder = getDivider()
        
        view.addSubview(btn)
        view.addSubview(label)
        view.addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            btn.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        return view
    }
    
    ///Метод для получение разделителя
    static func getDivider() -> UIView {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 0.33).isActive = true
        divider.backgroundColor = .white.withAlphaComponent(0.16)
        return divider
    }
    
    
    ///Метод для получения кастомных кнопок
    static func getCustomBtnForCreate(text: String, isDark: Bool, textColor: UIColor) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        btn.layer.cornerRadius = 8
        
        let sparklesImg = UIImageView(image: UIImage(named: isDark ? "sparklesDark" : "sparklesWithGradient"))
        sparklesImg.translatesAutoresizingMaskIntoConstraints = false
        sparklesImg.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 13) // SF PRO
        label.textAlignment = .center
        label.textColor = textColor
        
        btn.addSubview(sparklesImg)
        btn.addSubview(label)
        
        NSLayoutConstraint.activate([
            sparklesImg.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            sparklesImg.topAnchor.constraint(equalTo: btn.topAnchor, constant: 12),
            
            label.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: btn.bottomAnchor, constant: -12),
        ])
        
        return btn
    }
    
    ///Метод для получения тайтла
    static func getTitleForCreate(text: String = "") -> UILabel {
        let title = UILabel()
        title.text = text
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .left
        title.textColor = .labelPrimary
        title.font = .systemFont(ofSize: 20, weight: .semibold) // SF PRO
        return title
    }
    
    ///Метод для получения TextView который используется в двух модулях
    static func getTextView(delegate: UITextViewDelegate) -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 17) // SF PRO
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.textColor = .labelPrimary
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.separatorSecondary.cgColor
        textView.backgroundColor = .clear
        textView.delegate = delegate
        
        return textView
    }
    
//    $0.translatesAutoresizingMaskIntoConstraints = false

//    
//    $0.delegate = self
//    
//    $0.addSubview(startTextingLabel)
//    
//    NSLayoutConstraint.activate([
//        startTextingLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 12),
//        startTextingLabel.topAnchor.constraint(equalTo: $0.topAnchor, constant: 10),
//    ])
    
    ///Метод для получения получения кнопк
    static func getCustomBtn(action: UIAction, text: String, textColor: UIColor = .accentSecondaryDark) -> UIButton {
        let btn = UIButton(primaryAction: action)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.layer.cornerRadius = 8
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17) // SF PRO
        label.textColor = textColor
        
        btn.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: btn.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: btn.trailingAnchor),
            label.topAnchor.constraint(equalTo: btn.topAnchor),
            label.bottomAnchor.constraint(equalTo: btn.bottomAnchor),
        ])
         
        return btn
    }
    
    ///Метод для возможности изменения цвета лейла
    static func getCustomBtnForChangeLabel(action: UIAction, label: UILabel) -> UIButton {
        let btn = UIButton(primaryAction: action)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.layer.cornerRadius = 8
        
        btn.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: btn.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: btn.trailingAnchor),
            label.topAnchor.constraint(equalTo: btn.topAnchor),
            label.bottomAnchor.constraint(equalTo: btn.bottomAnchor),
        ])
         
        return btn
    }
    
    
    static func presentShareSheet(for fileURL: URL, from viewController: UIViewController) {
        let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        activityVC.excludedActivityTypes = [.assignToContact, .addToReadingList]
        
        // Для iPad (если используешь popover)
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = viewController.view
            popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX,
                                                  y: viewController.view.bounds.midY,
                                                  width: 0,
                                                  height: 0)
            popoverController.permittedArrowDirections = []
        }

        viewController.present(activityVC, animated: true)
    }
    
    ///Метод для пустой коллекции
    static func getEmptyView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var descriptLabel: UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "Create your first generation"
            $0.font = .systemFont(ofSize: 13) //SF PRO
            $0.textColor = .labelSecondary
            $0.numberOfLines = 1
            $0.textAlignment = .center
            return $0
        }(UILabel())
        
        lazy var labelText: UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "It's empty here"
            $0.font = .systemFont(ofSize: 20) //SF PRO
            $0.textColor = .labelPrimary
            $0.numberOfLines = 1
            $0.textAlignment = .center
            return $0
        }(UILabel())
        
        lazy var emptyImage: UIImageView = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 64).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 64).isActive = true
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .labelQuaternary
            $0.image = UIImage(systemName: "folder.badge.plus")
            return $0
        }(UIImageView())
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        backView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        backView.backgroundColor = .backgroundTertiary
        backView.layer.cornerRadius = 40
        backView.addSubview(emptyImage)
        
        NSLayoutConstraint.activate([
            emptyImage.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            emptyImage.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
        ])
        
        
        view.addSubview(descriptLabel)
        view.addSubview(labelText)
        view.addSubview(backView)
        
        NSLayoutConstraint.activate([
            descriptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            descriptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            labelText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            labelText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            labelText.bottomAnchor.constraint(equalTo: descriptLabel.topAnchor, constant: -6),
            
            backView.bottomAnchor.constraint(equalTo: labelText.topAnchor, constant: -6),
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }
    
    static func getSmallBtn(action: UIAction, label: UILabel, isFavorite: Bool = false) -> UIButton {
        let btn = UIButton(primaryAction: action)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 8
        btn.backgroundColor = isFavorite ? .backgroundTertiary : .backgroundSecondary
        
        btn.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: btn.topAnchor, constant: 7),
            label.bottomAnchor.constraint(equalTo: btn.bottomAnchor, constant: -7),
        ])
         
        return btn
    }
    
    
    
    ///Метод для получения кнопок в пейволе
    static func getPaywallPricesBtn(model: PriceModel, imageView: UIImageView) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.separatorPrimary.cgColor
        btn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        btn.backgroundColor = .clear
        btn.clipsToBounds = true
        
        
        if model.onSale {
            let salePriseLabel = UILabel()
            salePriseLabel.translatesAutoresizingMaskIntoConstraints = false
            salePriseLabel.font = .systemFont(ofSize: 11, weight: .semibold) // SF PRO
            salePriseLabel.textColor = .labelPrimary
            salePriseLabel.backgroundColor = .backgroundQuaternary
            salePriseLabel.text = "SAVE \(model.discountPersent)%"
            salePriseLabel.textAlignment = .center
            
            btn.addSubview(salePriseLabel)
            
            NSLayoutConstraint.activate([
                salePriseLabel.heightAnchor.constraint(equalToConstant: 24),
                salePriseLabel.widthAnchor.constraint(equalToConstant: 82),
                salePriseLabel.trailingAnchor.constraint(equalTo: btn.trailingAnchor),
                salePriseLabel.topAnchor.constraint(equalTo: btn.topAnchor)
            ])
            
            DispatchQueue.main.async {
                salePriseLabel.roundCorners([.bottomLeft], radius: 10)
            }
        }
        
        
        btn.addSubview(imageView)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 17, weight: .regular) // SF PRO
        title.textColor = .labelPrimary
        title.textAlignment = .left
        title.text = "Just $\(model.price) / \(model.period)"
        
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 1
        description.textColor = .labelQuaternary
        description.font = .systemFont(ofSize: 12) // SF PRO
        description.text = "Auto renewable. Cancel anytime."
        
        
        btn.addSubview(title)
        btn.addSubview(description)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            title.topAnchor.constraint(equalTo: btn.topAnchor, constant: 8),
            
            description.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            description.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2)
        ])
        
        return btn
    }
}
