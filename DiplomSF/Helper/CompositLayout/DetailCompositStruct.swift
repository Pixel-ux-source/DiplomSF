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
                return DetailFilmsLayout().layoutSection()
            }
        }
        return layout
    }
}

struct DetailFilmsLayout: CompositProtocol {
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(1000))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(2000))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}

enum SectionDetailCV: Int, CaseIterable {
    case info
}
