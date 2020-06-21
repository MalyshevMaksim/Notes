//
//  NotesDataSource.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NotesDataSource: UITableViewDiffableDataSource<Int, Int> {
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override init(tableView: UITableView, cellProvider: @escaping UITableViewDiffableDataSource<Int, Int>.CellProvider) {
        super.init(tableView: tableView, cellProvider: cellProvider)
        apply(makeSnapshot(), animatingDifferences: true)
    }
    
    func makeSnapshot() -> DataSourceSnapshot {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])
        snapshot.appendSections([1])
        
        for item in 0..<3 {
            snapshot.appendItems([item], toSection: 0)
        }
        
        for item in 3..<8 {
            snapshot.appendItems([item], toSection: 1)
        }
        return snapshot
    }
}
