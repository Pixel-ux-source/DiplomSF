//
//  MainDelegateCV.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import UIKit

final class MainDelegateCV: NSObject, UICollectionViewDelegate {
    var onReachEnd: (() -> Void)?
    
    var popularFilmsModel: [PopularFilmsModel] = []
    var coordinator: CoordinatorProtocol!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = popularFilmsModel[indexPath.row]
        coordinator.openDetailScreen(for: object)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !popularFilmsModel.isEmpty else { return }
        
        let thresholdIndex = popularFilmsModel.count - 2

        if indexPath.row >= thresholdIndex {
            onReachEnd?()
        }
    }
}
