//
//  ImageDetailDataSource.swift
//  DiplomSF
//
//  Created by Алексей on 22.10.2025.
//

import UIKit

final class ImageDetailDataSource: NSObject, UICollectionViewDataSource {
    var model: ImageModel?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.id, for: indexPath) as? ImageCell else { fatalError("ERROR_DEQUEUE_CELL_IMAGE") }
        
        guard let model else { return cell }
        
        let imageURLString = model.images[indexPath.item]
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(imageURLString)")
        let count: String = "\(indexPath.item + 1)/\(model.images.count)"
        cell.setUI(url: imageURL, countImages: count)

        return cell
    }
}
