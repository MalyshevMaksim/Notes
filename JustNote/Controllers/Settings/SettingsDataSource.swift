//
//  SettingsDataSource.swift
//  JustNote
//
//  Created by Максим on 18.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class SettingsDataSource: UITableViewDiffableDataSource<Int, Int> {
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    override init(tableView: UITableView, cellProvider: @escaping UITableViewDiffableDataSource<Int, Int>.CellProvider) {
        super.init(tableView: tableView, cellProvider: cellProvider)
        apply(makeSnapshot(), animatingDifferences: true)
    }
    
    private func makeSnapshot() -> DataSourceSnapshot {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])
        snapshot.appendSections([1])
        snapshot.appendSections([2])
        snapshot.appendSections([3])
        
        for item in 0..<2 {
            snapshot.appendItems([item], toSection: 1)
        }
        
        for item in 2..<5 {
            snapshot.appendItems([item], toSection: 2)
        }
        
        for item in 5..<7 {
            snapshot.appendItems([item], toSection: 3)
        }
        return snapshot
    }
}
