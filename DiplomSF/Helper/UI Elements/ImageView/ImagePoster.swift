//
//  ImagePoster.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

final class ImagePoster: UIImageView {
    // MARK: – Initializate
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Configure
    private func configure() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        isUserInteractionEnabled = true

    }
}
