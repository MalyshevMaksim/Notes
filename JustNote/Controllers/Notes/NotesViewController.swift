//
//  NotesViewController.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController {
    var dataSource: NotesDataSource!
    var delegate = NotesViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Typed"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        configureDataSource()
        configureController()
    }
    
    private func configureTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = delegate
    }
    
    private func configureDataSource() {
        dataSource = NotesDataSource(tableView: tableView, cellProvider: {
            (UITableView, indexPath, Int) -> UITableViewCell? in
            return self.configureCell(with: notes[indexPath.item], indexPath: indexPath)
        })
    }
    
    private func configureCell(with note: Note, indexPath: IndexPath) -> NoteCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell else {
            fatalError("Unable to dequeue")
        }
        cell.configure(with: note)
        return cell
    }
    
    private func configureController() {
        navigationItem.searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(setEditMode))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
    }
    
    @objc func setEditMode() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
}
