//
//  DetailDataSource.swift
//  DiplomSF
//
//  Created by Алексей on 02.10.2025.
//

import UIKit

final class DetailDataSource: NSObject, UICollectionViewDataSource {
    var infoModel: DetailModel?
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionDetailCV.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionDetailCV(rawValue: section)! {
        case .info:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCell.id, for: indexPath) as? InfoCell else { fatalError("ERROR_DEQUEUE_CELL_INFO") }
        guard let infoModel else { return cell }
        
        let title = infoModel.title
        let genre = infoModel.overview
        
        let imageURLString = infoModel.posterPath
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(imageURLString)") else {
            cell.setUI(title: title, genre: genre)
            return cell
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { [weak cell] data, response, error in
            guard
                let data,
                let image = UIImage(data: data)
            else {
                DispatchQueue.main.async {
                    cell?.setUI(title: title, genre: genre)
                }
                return
            }
            
            DispatchQueue.main.async {
                cell?.setUI(title: title, genre: genre, image: image)
                cell?.setNeedsLayout()
                cell?.layoutIfNeeded()
            }
        }
        task.resume()
        
        return cell
    }
    
    
}
