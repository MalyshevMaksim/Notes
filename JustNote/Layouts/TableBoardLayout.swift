//
//  TableBoardLayout.swift
//  JustNote
//
//  Created by Максим on 18.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

func setupTableLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout(section: makeSection())
    return layout
}

private func makeSection() -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: makeGroup())
    return section
}

private func makeGroup() -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
    let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [makeItem()])
    return groupLayout
}

private func makeItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
    return itemLayout
}
