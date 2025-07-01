//
//  CreatingVideoAnimateView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

final class CreatingVideoAnimateView: UIView {
    
    var action: (() -> ())?
    
    //MARK: - Functions
    func settupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .background
        
        addSubview(smallEllipse)
        addSubview(mediumEllipse)
        addSubview(largeEllipse)
        addSubview(exitBtn)
        addSubview(creatingVideoLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            smallEllipse.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 136),
            smallEllipse.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            
            mediumEllipse.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 177),
            mediumEllipse.topAnchor.constraint(equalTo: topAnchor, constant: 257),
            
            largeEllipse.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 112),
            largeEllipse.topAnchor.constraint(equalTo: topAnchor, constant: 315),
            
            exitBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11),
            exitBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44),
            
            creatingVideoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            creatingVideoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            creatingVideoLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -6),
        ])
        startLoadingAnimation()
    }
    
    private func getELlipseView(size: CGFloat) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: size).isActive = true
        view.widthAnchor.constraint(equalToConstant: size).isActive = true
        view.layer.cornerRadius = size / 2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            view.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
        }
        
        view.layer.opacity = 0.15
        
        return view
    }
    
    private func startLoadingAnimation() {
        let ellipses = [smallEllipse, mediumEllipse, largeEllipse]
        let radii: [CGFloat] = [6, 10, 14] // радиальные смещения

        for (index, ellipse) in ellipses.enumerated() {
            let delay = Double(index) * 0.2
            animateRadialOrbit(view: ellipse, radius: radii[index], delay: delay)
        }
    }

    private func animateRadialOrbit(view: UIView, radius: CGFloat, delay: TimeInterval) {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        
        let steps = 60
        var values: [CATransform3D] = []
        
        for i in 0..<steps {
            let angle = Double(i) / Double(steps) * 2 * Double.pi
            let x = radius * CGFloat(cos(angle))
            let y = radius * CGFloat(sin(angle))
            let transform = CATransform3DMakeTranslation(x, y, 0)
            values.append(transform)
        }
        
        animation.values = values
        animation.duration = 1.6
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.beginTime = CACurrentMediaTime() + delay
        view.layer.add(animation, forKey: "orbitTransform")
    }
    
    private func getLabel(text: String, font: UIFont, numberOfLine: Int, textColor: UIColor = .labelPrimary, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font // SF PRO
        label.numberOfLines = numberOfLine
        label.textColor = textColor
        label.textAlignment = alignment
        return label
    }
    
    //MARK: - View element
    private lazy var smallEllipse = getELlipseView(size: 82)
    private lazy var mediumEllipse = getELlipseView(size: 98)
    private lazy var largeEllipse = getELlipseView(size: 114)
    private lazy var creatingVideoLabel = getLabel(text: "Creating a video...", font: .systemFont(ofSize: 20, weight: .semibold), numberOfLine: 1, alignment: .center)
    private lazy var descriptionLabel = getLabel(text: "Generation usually takes about a minute", font: .systemFont(ofSize: 13), numberOfLine: 1, textColor: .labelSecondary, alignment: .center)
    
    private lazy var exitBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .accentPrimary
        $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return $0
    }(UIButton(primaryAction: exitAction))
    
    //MARK: - Actions
    private lazy var exitAction = UIAction { [weak self] _ in
        guard let self, let action else { return }
        action()
    }
}
