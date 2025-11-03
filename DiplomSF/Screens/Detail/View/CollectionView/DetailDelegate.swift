//
//  DetailDelegate.swift
//  DiplomSF
//
//  Created by Алексей on 02.10.2025.
//

import UIKit

final class DetailDelegate: NSObject, UICollectionViewDelegate {
    var model: DetailModel?
    var coordinator: CoordinatorProtocol!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = SectionDetailCV(rawValue: indexPath.section)!
        
        switch section {
        case .info:
            collectionView.deselectItem(at: indexPath, animated: false)
        case .photos:
            guard let model else { return }
            let photos = model.images
            coordinator.openDetailImage(for: photos, index: indexPath)
        }
    }
}
