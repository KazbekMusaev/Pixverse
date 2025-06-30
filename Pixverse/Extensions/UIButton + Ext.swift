//
//  UIButton + Ext.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import UIKit

extension UIButton {
    func clickAnimate() {
        UIView.animate(withDuration: 0.1,
                       animations: {
            self.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
            self.layer.shadowOpacity = 0.2
        }, completion: { _ in
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 6,
                           options: .allowUserInteraction,
                           animations: {
                self.transform = CGAffineTransform.identity
                self.layer.shadowOpacity = 0
            })
        })
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
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
