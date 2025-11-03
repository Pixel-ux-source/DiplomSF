//
//  FavoriteButton.swift
//  DiplomSF
//
//  Created by Алексей on 21.10.2025.
//

import UIKit

final class FavoriteButton: UIButton {
    // MARK: – Override
    override var isSelected: Bool {
        didSet {
            configureImage()
        }
    }
    
    // MARK: – Variable
    var didTapAction: (() -> Void)?
    
    // MARK: – Instance's
    private let hitAreaePadding: CGFloat = 8
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let largerArea = bounds.insetBy(dx: -hitAreaePadding, dy: -hitAreaePadding)
        return largerArea.contains(point)
    }
    
    // MARK: –  Initializate
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureElement()
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Configuration's
    private func configureElement() {
        backgroundColor = .none
        configureImage()
        imageView?.contentMode = .scaleAspectFit
        imageView?.tintColor = .systemRed
    }
    
    private func configureImage() {
        setImage(UIImage(systemName: "bookmark"), for: .normal)
        setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
    }
    
    // MARK: – @Objc func
    @objc
    private func didTap() {
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        } completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 6,
                           options: .allowAnimatedContent) {
                self.transform = .identity
            } completion: { _ in }
        }
    }
}
