//
//  NotesViewController.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController {
    var dataSource: Data!
    var delegate = NotesViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Typed"
        
        configureTableView()
        configureDataSource()
        configureSearchBar()
    }
    
    private func configureTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = delegate
    }
    
    private func configureDataSource() {
        dataSource = Data(tableView: tableView, cellProvider: {
            (UITableView, indexPath, Int) -> UITableViewCell? in
            return self.makeCell(with: Note(title: "How programming on Swift?", text: "Let me explain something about me, I’m IOS Developer about 4 years. When i try to build my first app i use storyboards, xib after that I convert my self into create everything programmatically. I’m not say this is the best way or only way but i prefer to continue like this. When i create something programmatically I feel like free as possible as be. So this is my first Medium story and sorry if I do something wrong.", tag: "123"), indexPath: indexPath)
        })
    }
    
    private func makeCell(with note: Note, indexPath: IndexPath) -> NoteCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell else {
            fatalError("Unable to dequeue")
        }
        cell.configure(with: note)
        return cell
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = UISearchController()
    }
}
