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
    static func getCustomBtnForCreate(text: String, isDark: Bool) -> UIButton {
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
    static func getTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }
    
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
        label.font = .systemFont(ofSize: 17) // SF PRO
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
    
    
    ///Метод для получения алерта из 3х кнопок
    
}
