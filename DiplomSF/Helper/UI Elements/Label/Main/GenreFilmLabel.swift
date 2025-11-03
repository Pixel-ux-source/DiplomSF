//
//  DescLabel.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

final class GenreFilmLabel: UILabel {
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
        textColor = .lightGray
        font = .systemFont(ofSize: 14, weight: .medium)
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
        textAlignment = .left
    }
}
