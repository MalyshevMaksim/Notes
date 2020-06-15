//
//  NoteBoardsDataSource.swift
//  JustNote
//
//  Created by Максим on 15.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Int>
typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>

class NoteBoardsDataSource: DataSource {
    var collectionView: UICollectionView?
    var dataSource: DataSource?
    
    init(collectionView: UICollectionView?) {
        super.init()
        self.collectionView = collectionView
        setupDataSource()
    }
    
    private func setupDataSource() {
        guard let collectionView = collectionView else {
            return
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, Identifer) -> UICollectionViewCell? in
            return self.setupCellWith(indexPathForCell: indexPath)
        }
        dataSource!.apply(makeSnapshot(), animatingDifferences: true)
    }
    
    private func setupCellWith(indexPathForCell: IndexPath) -> UICollectionViewCell {
        guard let collectionView = collectionView else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BorderCollectionCell.reuseIdentifier, for: indexPathForCell) as! BorderCollectionCell
        cell.borderOfNotesModel = bordersOfNotes[indexPathForCell.item]
        return cell
    }
    
    private func makeSnapshot() -> DataSourceSnapshot {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])
        
        for item in 0..<bordersOfNotes.count {
            snapshot.appendItems([item])
        }
        return snapshot
    }
}
