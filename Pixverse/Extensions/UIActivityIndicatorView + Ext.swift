//
//  UIActivityIndicatorView + Ext.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

extension UIActivityIndicatorView {
    static func getIndicator() -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.backgroundColor = UIColor.backgroundTertiary
        activityIndicatorView.color = .accentSecondary
        activityIndicatorView.style = .large
        activityIndicatorView.startAnimating()
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicatorView.layer.cornerRadius = 12
        return activityIndicatorView
    }
}
