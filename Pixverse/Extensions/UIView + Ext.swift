//
//  UIView + Ext.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

extension UIView {
    func addDarkBlurEffect(radius: CGFloat = 20, opacity: Float = 0.7) {
        // 1. Темный подложечный слой
        let darkView = UIView()
        darkView.frame = self.bounds
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        darkView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        darkView.layer.cornerRadius = self.layer.cornerRadius
        darkView.layer.masksToBounds = true
        self.insertSubview(darkView, at: 0)
        
        // 2. Размытие с темным стилем
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark) // Используем DARK стиль
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = CGFloat(opacity)
        blurView.layer.cornerRadius = self.layer.cornerRadius
        blurView.layer.masksToBounds = true
        
        self.insertSubview(blurView, aboveSubview: darkView)
        
        // 3. Настройка тени (опционально)
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
    }
    
    func addHorizontalGradient(colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.frame = self.bounds
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.name = "gradientLayer"
        
        self.layer.sublayers?.filter { $0.name == "gradientLayer" }.forEach { $0.removeFromSuperlayer() }
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
