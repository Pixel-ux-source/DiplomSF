//
//  CompositStruct.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

// MARK: – Main Collection
struct MainLayoutProvider {
    static func loadLayout(onReachEnd: @escaping () -> Void) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionMain = SectionMainCV(rawValue: sectionIndex) else { return nil }
            switch sectionMain {
            case .popularFilms:
                var section = PopularFilmsSection()
                section.onReachEnd = onReachEnd
                return section.layoutSection()
            }
        }
        return layout
    }
}

struct PopularFilmsSection: CompositProtocol {
    var onReachEnd: (() -> Void)?

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .absolute(350))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 8, leading: 16, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(50))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        section.visibleItemsInvalidationHandler = { items, offset, environment in
            let maxOffset = environment.container.contentSize.width - environment.container.contentSize.width * 1.1
            if offset.x > maxOffset {
                onReachEnd?()
            }
        }
        return section
    }
}

enum SectionMainCV: Int, CaseIterable {
    case popularFilms
}
