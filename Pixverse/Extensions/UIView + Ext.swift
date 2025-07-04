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
    
    func addDashedBorder(color: UIColor = .black, width: CGFloat = 1, dashPattern: [NSNumber] = [4, 2]) {
        
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineDashPattern = dashPattern
        borderLayer.lineWidth = width
        borderLayer.frame = self.bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        
        self.layer.sublayers?.filter { $0.name == "dashedBorder" }.forEach { $0.removeFromSuperlayer() }
        
        borderLayer.name = "dashedBorder"
        self.layer.addSublayer(borderLayer)
    }

    
    func createGradientBackground(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.60]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
