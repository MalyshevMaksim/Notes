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
    var dataSource: UITableViewDiffableDataSource<Int, Int>!
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupDataSource()
    }
}
