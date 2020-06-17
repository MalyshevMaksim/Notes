//
//  NoteBoardsDataSource.swift
//  JustNote
//
//  Created by Максим on 15.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<BoardSection, NoteBoard>
typealias DataSource = UICollectionViewDiffableDataSource<BoardSection, NoteBoard>

extension NoteBoardsViewController {
    func makeDataSource() -> DataSource  {
        let dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, board) -> UICollectionViewCell? in
            
            switch self.sections[indexPath.section].type {
            case "defaultBoardings":
                return self.makeCell(BoardCollectionCell.self, with: board, for: indexPath)
            default:
                return UICollectionViewCell()
            }
        }
        dataSource.apply(makeSnapshot(), animatingDifferences: true)
        return dataSource
    }
    
    private func makeCell<T: ConfiguringCell>(_ cellType: T.Type, with noteBoarding: NoteBoard, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: noteBoarding)
        return cell
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