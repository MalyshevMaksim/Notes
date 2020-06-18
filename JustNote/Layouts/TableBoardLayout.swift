//
//  TableBoardLayout.swift
//  JustNote
//
//  Created by Максим on 18.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

func setupTableLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout(section: makeLineSection())
    return layout
}

private func makeLineSection() -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: makeLineGroup())
    return section
}

private func makeLineGroup() -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.4))
    let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [makeLineItem()])
    return groupLayout
}

private func makeLineItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
    let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
    return itemLayout
}
