//
//  DetailLabel.swift
//  DiplomSF
//
//  Created by Алексей on 07.10.2025.
//

import UIKit

final class DetailTitleLabel: UILabel {
    // MARK: – Initializate
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Configuration's
    private func configureElement() {
        textColor = .black
        font = .systemFont(ofSize: 26, weight: .bold)
        numberOfLines = 0
        textAlignment = .left
    }
}
