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
    
    func setupDataSource() {
        dataSource = DataSource(tableView: tableView) {
            (tableView, indexPath, Identifier) -> UITableViewCell? in
            
            return self.makeCell(with: SettingRow(text: "Appearance", iconName: "folder.fill"), indexPath: indexPath)
        }
        dataSource.apply(makeSnapshot(), animatingDifferences: true)
    }
    
    private func makeCell(with settingRow: SettingRow, indexPath: IndexPath) -> SettingCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as? SettingCell else {
            fatalError("Unable to dequeue")
        }
        cell.configure(with: settingRow)
        return cell
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
