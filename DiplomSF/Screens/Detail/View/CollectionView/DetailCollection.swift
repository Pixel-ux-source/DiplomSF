//
//  DetailCollectionView.swift
//  DiplomSF
//
//  Created by Алексей on 02.10.2025.
//

import UIKit

final class DetailCollection: UICollectionView {
    // MARK: – Initializate
    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        registerCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Configuration's
    private func registerCell() {
        register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.id)
    }
}
