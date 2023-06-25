//
//  CategorySection.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 23.06.2023.
//

import UIKit

// MARK: - CategorySection
final class CategorySection: Section {
    func layoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(20),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: .fixed(8),
            top: .fixed(0),
            trailing: .fixed(8),
            bottom: .fixed(0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .estimated(20),
                heightDimension: .absolute(44)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}

