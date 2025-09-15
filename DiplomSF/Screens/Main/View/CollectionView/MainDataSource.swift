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
        let raiting = popularFilmsModel[indexPath.row].voteAverage
        let title = popularFilmsModel[indexPath.row].originalTitle
        let genre = popularFilmsModel[indexPath.row].overview
        let imagePath = popularFilmsModel[indexPath.row].posterPath
        
        cell.setUI(raiting: raiting, title: title, genre: genre)
        
        let image = cell.getImageView()
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(imagePath)") else { return cell }
        
        let placeholderImage = UIImage(systemName: "photo")
        image.sd_setImage(with: url, placeholderImage: placeholderImage)
        image.tintColor = .systemGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
        
        header.configure(with: "Popular")
        return header
    }
}
