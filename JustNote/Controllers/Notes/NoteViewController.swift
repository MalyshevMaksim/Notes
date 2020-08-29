//
//  NotesViewController.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit
import CoreData

protocol ViewСontrollerPresenting {
    func showAlert(alert: UIViewController)
    func showNextController(with note: TextNote)
}

class NoteViewController: UITableViewController, ViewСontrollerPresenting {
    var fetchResultControllerDelegate: NoteFetchResultsControllerDelegate!
    var dataSource = NoteDataSource()
    var delegate = NoteDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        configureController()
    }
    
    private func configureTableView() {
        fetchResultControllerDelegate = NoteFetchResultsControllerDelegate(tableView: tableView)
        CoreDataStack.shared.fetchRequestController.delegate = fetchResultControllerDelegate
        
        tableView.delegate = delegate
        delegate.parentController = self
        tableView.dataSource = dataSource
        tableView.backgroundColor = .systemBackground
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
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
    
    func showAlert(alert: UIViewController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNextController(with note: TextNote) {
        let detailController = DetailNoteController()
        detailController.note = note
        navigationController?.pushViewController(detailController, animated: true)
    }
}
