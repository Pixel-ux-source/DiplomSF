//
//  MainDelegateCV.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import UIKit

final class MainDelegateCV: NSObject, UICollectionViewDelegate {
    var popularFilmsModel: [PopularFilmsModel] = []
    var coordinator: CoordinatorProtocol!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = popularFilmsModel[indexPath.row]
        coordinator.openDetailScreen(for: object)
    }
}
