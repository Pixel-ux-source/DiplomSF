//
//  MainCV.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import UIKit

final class MainCollection: UICollectionView {
    
    // MARK: – Initializate
    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configureView()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Register Cell
    private func registerCell() {
        register(PopularFilmCell.self, forCellWithReuseIdentifier: PopularFilmCell.id)
        register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.id)
    }
    
    // MARK: – Configure View
    private func configureView() {
        backgroundColor = .systemBackground
    }
}

enum SectionMainCV: Int, CaseIterable {
    case popularFilms
}
