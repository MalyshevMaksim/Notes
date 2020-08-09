//
//  GridBoardLayout.swift
//  JustNote
//
//  Created by Максим on 18.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

enum Section: Int, CaseIterable {
    case list
    case grid

    var columnCount: Int {
        switch self {
        case .list:
            return 1
        case .grid:
            return 2
        }
    }
}

func setupGridLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
        switch sectionIndex {
        case 1:
            return makeGridSection()
        default:
            return makeListSection()
        }
    }
    return layout
}

// MARK: LIST LAYOUT
private func makeListSection() -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: makeListGroup())
    section.boundarySupplementaryItems = [makeHeader()]
    section.orthogonalScrollingBehavior = .groupPaging
    return section
}

private func makeListGroup() -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalWidth(0.45))
    let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [makeListItem()])
    return groupLayout
}

private func makeListItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
    return itemLayout
}


// MARK: GRID LAYOUT
private func makeGridSection() -> NSCollectionLayoutSection {
    let section = NSCollectionLayoutSection(group: makeGridGroup())
    section.boundarySupplementaryItems = [makeHeader()]
    return section
}

private func makeGridGroup() -> NSCollectionLayoutGroup {
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.38))
    let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [makeGridItem()])
    groupLayout.interItemSpacing = .fixed(15)
    groupLayout.edgeSpacing = .init(leading: .fixed(20), top: nil, trailing: .fixed(20), bottom: .fixed(15))
    return groupLayout
}

private func makeGridItem() -> NSCollectionLayoutItem {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.428), heightDimension: .fractionalHeight(1))
    let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
    return itemLayout
}





private func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ElementKind.headerKind, alignment: .top)
    return header
}
