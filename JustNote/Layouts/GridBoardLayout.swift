//
//  GridBoardLayout.swift
//  JustNote
//
//  Created by Максим on 18.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

func setupGridLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout(section: makeSection())
    return layout
}

private func makeSection() -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: makeGroup())
    section.boundarySupplementaryItems = [makeHeader()]
    return section
}

private func makeGroup() -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.4))
    let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [makeItem()])
    groupLayout.interItemSpacing = .fixed(10)
    return groupLayout
}

private func makeItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(1))
    let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
    itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
    return itemLayout
}

private func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ElementKind.headerKind, alignment: .top)
    return header
}
