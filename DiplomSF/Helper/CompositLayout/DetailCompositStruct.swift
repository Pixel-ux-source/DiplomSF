//
//  DetailCompositStruct.swift
//  DiplomSF
//
//  Created by Алексей on 06.10.2025.
//

import UIKit

// MARK: – Detail Collection
struct DetailLayoutProvider {
    static func loadLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionDetail = SectionDetailCV(rawValue: sectionIndex) else { return nil }
            switch sectionDetail {
            case .info:
                return DetailFilmsLayout().layoutInfoSection()
            case .photos:
                return DetailFilmsLayout().layoutPhotosSection()
            }
        }
        return layout
    }
}

struct DetailFilmsLayout: CompositProtocol {
    func layoutInfoSection() -> NSCollectionLayoutSection {
        let estimatedHeight = NSCollectionLayoutDimension.estimated(800)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: estimatedHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: estimatedHeight)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
    
    func layoutPhotosSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(230),
                                              heightDimension: .absolute(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(230),
                                               heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}

enum SectionDetailCV: Int, CaseIterable {
    case info
    case photos
}
