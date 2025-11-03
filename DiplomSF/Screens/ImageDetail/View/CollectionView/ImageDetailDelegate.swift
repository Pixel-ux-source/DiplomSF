//
//  ImageDetailDelegate.swift
//  DiplomSF
//
//  Created by Алексей on 23.10.2025.
//

import UIKit

final class ImageDetailDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
}
