//
//  GridBoardLayout.swift
//  JustNote
//
//  Created by Максим on 18.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

func setupGridLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout(section: createSection())
    return layout
}

private func createSection() -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: createGroup())
    section.boundarySupplementaryItems = [setupHeader()]
    return section
}

private func createGroup() -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.4))
    let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [createItem()])
    return groupLayout
}

private func createItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
    let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
    itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5)
    return itemLayout
}

private func setupHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ElementKind.HeaderKind, alignment: .top)
    return header
}
