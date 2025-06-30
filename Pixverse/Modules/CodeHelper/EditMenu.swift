//
//  EditMenu.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

// 1. Модель для пунктов меню
struct EditMenuItem {
    let title: String
    let image: UIImage?
    let action: () -> Void
    var isDestructive: Bool = false
}

// 2. Кастомное меню
class EditMenuView: UIView {
    
    private let items: [EditMenuItem]
    private let sourceView: UIView
    
    init(items: [EditMenuItem], sourceView: UIView) {
        self.items = items
        self.sourceView = sourceView
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 14
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.2
//        layer.shadowRadius = 20
//        layer.shadowOffset = CGSize(width: 0, height: 5)
        addDarkBlurEffect()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        items.enumerated().forEach { index, item in
            let button = UIButton(type: .system)
            button.setTitle(item.title, for: .normal)
            
            let image = UIImageView()
            image.image = item.image
            image.tintColor = item.isDestructive ? .accentRed : .labelPrimary
            image.frame.origin.x = button.bounds.maxX - 20
            
            button.addSubview(image)
            button.tintColor = item.isDestructive ? .accentRed : .labelPrimary
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
            button.addTarget(self, action: #selector(itemTapped(_:)), for: .touchUpInside)
            button.tag = index
            stackView.addArrangedSubview(button)
            
            if index < items.count - 1 {
                let separator = UIView()
                separator.backgroundColor = .separator
                separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
                stackView.addArrangedSubview(separator)
            }
        }
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Рассчитываем размер
        let width = items.map { $0.title.width(withFont: .systemFont(ofSize: 16)) }.max() ?? 0
        let height = CGFloat(items.count * 44)
        frame.size = CGSize(width: width + 80, height: height)
    }
    
    @objc private func itemTapped(_ sender: UIButton) {
        items[sender.tag].action()
        dismiss()
    }
    
    func show(in view: UIView) {
        // Позиционируем меню относительно sourceView
        let sourceFrame = sourceView.convert(sourceView.bounds, to: view)
        frame.origin = CGPoint(
            x: sourceFrame.midX - frame.width/2,
            y: sourceFrame.maxY + 8
        )
        
        // Корректируем положение, если выходит за границы
        frame.origin.x = max(16, min(frame.origin.x, view.bounds.width - frame.width - 16))
        frame.origin.y = min(frame.origin.y, view.bounds.height - frame.height - 16)
        
        // Добавляем затемнение
        let dimmingView = UIView(frame: view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        dimmingView.alpha = 0
        dimmingView.tag = 999
        
        view.addSubview(dimmingView)
        view.addSubview(self)
        
        // Анимация появления
        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            self.alpha = 1
            self.transform = .identity
            dimmingView.alpha = 1
        })
    }
    
    
    @objc func dismiss() {
        guard let superview = superview else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            superview.viewWithTag(999)?.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
            superview.viewWithTag(999)?.removeFromSuperview()
        })
    }
}


extension String {
    func width(withFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension UIViewController {
    func showEditMenu(for view: UIView, items: [EditMenuItem]) {
        let menu = EditMenuView(items: items, sourceView: view)
        menu.show(in: self.view)
    }
}
