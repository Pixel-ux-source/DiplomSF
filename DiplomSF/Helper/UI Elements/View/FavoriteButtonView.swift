//
//  FavoriteButtonView.swift
//  DiplomSF
//
//  Created by Алексей on 21.10.2025.
//

import UIKit
import PinLayout

final class FavoriteButtonView: UIView {
    // MARK: – UI Element's
    private lazy var favoriteButton: UIButton = {
        let button = FavoriteButton(type: .custom)
        return button
    }()
    
    private var action: (() -> Void)?
    
    // MARK: – Initializate
    init(frame: CGRect = .zero, action: @escaping () -> Void) {
        self.action = action
        super.init(frame: frame)
        setupButton()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    // MARK: – Configuration's
    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 2
    }
    
    // MARK: – Setup's
    private func setupButton() {
        addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        favoriteButton.pin.sizeToFit()
        self.pin.wrapContent(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
    }
    
    func update(isSelected: Bool) {
        favoriteButton.isSelected = isSelected
    }
    
    // MARK: – @Objc func
    @objc
    private func didTapButton() {
        favoriteButton.isSelected.toggle()
        action?()
    }
}
