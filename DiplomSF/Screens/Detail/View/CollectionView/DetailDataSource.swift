//
//  DetailDataSource.swift
//  DiplomSF
//
//  Created by Алексей on 02.10.2025.
//

import UIKit

// Добавить на главной странице две кнопки – избранное и смену языка ENG/RUS с алертом на просьбу перезапустить приложение для смены языка
// Опционально добавить Skeleton

final class DetailDataSource: NSObject, UICollectionViewDataSource {
    var model: DetailModel?
    var presenter: DetailPresenterProtocol!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionDetailCV.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionDetailCV(rawValue: section)! {
        case .info:
            return 1
        case .photos:
            return model?.images.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionDetailCV(rawValue: indexPath.section)! {
        case .info:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoDetailCell.id, for: indexPath) as? InfoDetailCell else { fatalError("ERROR_DEQUEUE_CELL_INFO") }
            guard let model else { return cell }
            
            let title = model.title
            let genre = model.overview
            let originalTitle = model.originalTitle
            let voteAverage = model.voteAverage
            let date = model.releaseDate
            let isFavorite = model.isFavorite
            
            let imageURLString = model.posterPath
            guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(imageURLString)") else {
                cell.setUI(title: title, genre: genre, originalTitle: originalTitle, voteAverage: voteAverage, date: date, isFavorite: isFavorite)
                return cell
            }
            
            let task = URLSession.shared.dataTask(with: imageURL) { [weak cell] data, response, error in
                guard
                    let data,
                    let cell,
                    let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                        cell?.setUI(title: title, genre: genre, originalTitle: originalTitle, voteAverage: voteAverage, date: date, isFavorite: isFavorite)
                        collectionView.collectionViewLayout.invalidateLayout()
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    cell.setUI(title: title, genre: genre, originalTitle: originalTitle, voteAverage: voteAverage, image: image, date: date, isFavorite: isFavorite)
                    cell.setNeedsLayout()
                    cell.layoutIfNeeded()
                    collectionView.collectionViewLayout.invalidateLayout()
                }
            }
            task.resume()
            
            cell.onFavoriteButtonTapped = { [weak self] in
                guard let self else { return }
                self.presenter.toggleFavorite()
            }
            
            return cell
        case .photos:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FramesDetailCell.id, for: indexPath) as? FramesDetailCell else { fatalError("ERROR_DEQUEUE_CELL_PHOTOS") }
            guard let model else { return cell }
            let image = model.images[indexPath.row]
            
            let imageURL = URL(string: image)
            cell.setUI(url: imageURL)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
        
        header.configure(with: "Кадры")
        
        return header
    }
}
