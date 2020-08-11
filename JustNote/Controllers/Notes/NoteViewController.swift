//
//  NotesViewController.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UITableViewController {
    var applicationDataDelegate: NoteFetchResultsControllerDelegate!
    var applicationData: CoreDataController!
    var dataSource: NoteDataSource!
    var delegate: NoteDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        configureController()
    }
    
    private func configureTableView() {
        applicationData = CoreDataController()
        dataSource = NoteDataSource(with: applicationData)
        
        delegate = NoteDelegate()
        delegate.viewController = self
        
        applicationDataDelegate = NoteFetchResultsControllerDelegate(tableView: tableView, with: applicationData)
        applicationData.controller.delegate = applicationDataDelegate
        
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.backgroundColor = .systemBackground
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
    }
    
    private func configureController() {
        navigationItem.searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = false
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
