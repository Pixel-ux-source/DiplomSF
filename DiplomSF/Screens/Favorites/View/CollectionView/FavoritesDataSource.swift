//
//  FavoritesDataSource.swift
//  DiplomSF
//
//  Created by Алексей on 03.11.2025.
//

import UIKit

final class FavoritesDataSource: NSObject, UICollectionViewDataSource {
    var models: [PopularFilmsModel] = []
    var presenter: FavoritesPresenterProtocol!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteFilmCell.id, for: indexPath) as? FavoriteFilmCell else { fatalError("ERROR_DequeueReusableCell") }
        let model = models[indexPath.item]
        cell.setUI(with: model)
        cell.onFavoriteButtonTapped = { [weak self] in
            guard let self else { return }
            self.presenter.toggleFavorite(id: model.id)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
        header.configure(with: "Избранное", insetLeft: 16)
        return header
    }
}


