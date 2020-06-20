//
//  File.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    var dataSource: SettingsDataSource!
    var delegate = SettingsDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        configureDataSource()
    }
    
    private func configureTableView() {
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = delegate
    }
    
    private func configureDataSource() {
        dataSource = SettingsDataSource(tableView: tableView) {
            (tableView, indexPath, Identifier) -> UITableViewCell? in
            return self.configureCell(with: SettingRow(text: "Appearance", iconName: "folder.fill"), indexPath: indexPath)
        }
    }
    
    private func configureCell(with settingRow: SettingRow, indexPath: IndexPath) -> SettingCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as? SettingCell else {
            fatalError("Unable to dequeue")
        }
        cell.configure(with: settingRow)
        return cell
    }
}
