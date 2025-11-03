//
//  ImageDetailCollection.swift
//  DiplomSF
//
//  Created by Алексей on 22.10.2025.
//

import UIKit

final class ImageDetailCollection: UICollectionView {
    // MARK: – Layout
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }()
        
    // MARK: – Initializate
    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: self.layout)
        registerCell()
        configureCollection()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Configuration's
    private func registerCell() {
        register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.id)
    }
    
    private func configureCollection() {
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        contentInsetAdjustmentBehavior = .never
        backgroundColor = .systemBackground
    }
}
