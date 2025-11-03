//
//  FavoritesCollection.swift
//  DiplomSF
//
//  Created by Алексей on 03.11.2025.
//

import UIKit

final class FavoritesCollection: UICollectionView {
    // MARK: – Initializate
    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configureView()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Register Cell
    private func registerCell() {
        register(FavoriteFilmCell.self, forCellWithReuseIdentifier: FavoriteFilmCell.id)
        register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.id)
    }
    
    // MARK: – Configure View
    private func configureView() {
        backgroundColor = .systemBackground
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
}


