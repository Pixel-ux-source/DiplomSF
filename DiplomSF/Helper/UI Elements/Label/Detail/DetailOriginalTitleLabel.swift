//
//  DetailOriginalTitle.swift
//  DiplomSF
//
//  Created by Алексей on 17.10.2025.
//

import UIKit

final class DetailOriginalTitleLabel: UILabel {
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
        textColor = .systemGray
        font = .systemFont(ofSize: 14, weight: .regular)
        numberOfLines = 0
        textAlignment = .left
    }
}
