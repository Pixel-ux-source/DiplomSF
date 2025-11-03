//
//  MainDataSource.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import UIKit
import SDWebImage

final class MainDataSource: NSObject, UICollectionViewDataSource {
    var popularFilmsModel: [PopularFilmsModel] = []
    var presenter: MainPresenterProtocol!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionMainCV.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionMainCV(rawValue: section)! {
        case .popularFilms:
            popularFilmsModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularFilmCell.id, for: indexPath) as? PopularFilmCell else { fatalError("ERROR_DequeueReusableCell") }
        
        let model = popularFilmsModel[indexPath.item]
        cell.setUI(with: model)
        cell.onFavoriteButtonTapped = { [weak self] in
            guard let self else { return }
            self.presenter.toggleFavorite(index: model.id)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
        
        header.configure(with: "Популярное")
        return header
    }
}
