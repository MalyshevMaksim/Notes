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
    var delegate: NotesViewDelegate!
    
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
        delegate = NotesViewDelegate(parentViewController: navigationController!)
        tableView.delegate = delegate
        tableView.allowsMultipleSelectionDuringEditing = true
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
        //navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(setEditMode))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(setEditMode))
    }
    
    private func updateLeftBarButton() {
       if tableView.isEditing == true {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setEditMode))
       }
       else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(setEditMode))
            tabBarController?.tabBar.isHidden = false
       }
    }
    
    @objc func setEditMode() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.style = tableView.isEditing ? .done : .plain
        updateLeftBarButton()
    }
}
