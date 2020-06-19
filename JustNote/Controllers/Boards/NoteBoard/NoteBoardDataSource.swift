//
//  NoteBoardsDataSource.swift
//  JustNote
//
//  Created by Максим on 15.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NoteBoardDataSource: UICollectionViewDiffableDataSource<BoardSection, NoteBoard> {
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<BoardSection, NoteBoard>
    
    override init(collectionView: UICollectionView, cellProvider: @escaping UICollectionViewDiffableDataSource<BoardSection, NoteBoard>.CellProvider) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
        makeSupplementaryProvider()
        apply(makeSnapshot(), animatingDifferences: true)
    }
    
    private func makeSupplementaryProvider() {
        self.supplementaryViewProvider = {
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderGridLayout.reuseIdentifier, for: indexPath) as! HeaderGridLayout
            header.configure(with: sections[indexPath.section])
            return header
        }
    }

    private func makeSnapshot() -> DataSourceSnapshot {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([sections[0]])
        
        for item in 0..<sections[0].items.count {
            snapshot.appendItems([sections[0].items[item]])
        }
        return snapshot
    }
}
