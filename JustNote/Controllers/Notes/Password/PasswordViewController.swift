//
//  PasswordViewController.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/28/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class PasswordViewController: UITableViewController {
    var fetchResultControllerDelegate: NoteFetch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(PasswordCell.self, forCellReuseIdentifier: PasswordCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(s))
        navigationItem.searchController = UISearchController()
        
        fetchResultControllerDelegate = NoteFetch(tableView: tableView)
        CoreDataStack.shared.fetchRequestController2.delegate = fetchResultControllerDelegate
    }
    
    @objc func s() {
        let modalViewController = UINavigationController(rootViewController: ModalViewController())
        modalViewController.modalPresentationStyle = .formSheet
        present(modalViewController, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return CoreDataStack.shared.fetchRequestController2.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataStack.shared.fetchRequestController2.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CoreDataStack.shared.fetchRequestController2.sections![section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PasswordCell.reuseIdentifier, for: indexPath) as? PasswordCell else {
            fatalError("Error: Unable to dequeue")
        }
        cell.configure(with: CoreDataStack.shared.fetchRequestController2.object(at: indexPath))
        return cell
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let note = CoreDataStack.shared.fetchRequestController2.object(at: indexPath)
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            CoreDataStack.shared.managedContext.delete(note)
            CoreDataStack.shared.saveContext()
        }
        action.image = UIImage(systemName: "trash.fill")
        return action
    }
    
    func pinnedAction(at indexPath: IndexPath) -> UIContextualAction {
        let note = CoreDataStack.shared.fetchRequestController2.object(at: indexPath)
        let title = note.isPinned ? "Unpin" : "Pin"
        let icon = UIImage(systemName: note.isPinned ? "pin.slash.fill" : "pin.fill")
        
        let action = UIContextualAction(style: .normal, title: title) { (action, view, completion) in
            if note.isPinned {
                note.section = "Others"
            }
            else {
                note.section = "Pinned"
            }
            note.isPinned.toggle()
            CoreDataStack.shared.saveContext()
        }
        action.backgroundColor = .systemBlue
        action.image = icon
        return action
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [deleteAction(at: indexPath), pinnedAction(at: indexPath)])
    }
}
