//
//  SettingsDataSource.swift
//  JustNote
//
//  Created by Максим on 18.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

extension SettingsViewController {
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Int>
    typealias DataSource = UITableViewDiffableDataSource<Int, Int>
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) {
            (tableView, indexPath, Identifier) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewController.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = "123"
            return cell
        }
        
        dataSource.apply(makeSnapshot(), animatingDifferences: true)
        return dataSource
    }
    
    private func makeSnapshot() -> DataSourceSnapshot {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])
        
        for item in 0..<5 {
            snapshot.appendItems([item])
        }
        return snapshot
    }
}
