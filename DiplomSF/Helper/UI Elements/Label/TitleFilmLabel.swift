//
//  TitleFilm.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

final class TitleFilmLabel: UILabel {
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
        font = .systemFont(ofSize: 18, weight: .semibold)
        numberOfLines = 2
        lineBreakMode = .byTruncatingTail
        textAlignment = .left
    }
}
