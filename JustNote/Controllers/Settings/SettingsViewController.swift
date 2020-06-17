//
//  File.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    static var reuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.137254902, blue: 0.1568627451, alpha: 1)
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SettingsViewController.reuseIdentifier)
        tableView.dataSource = makeDataSource()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
