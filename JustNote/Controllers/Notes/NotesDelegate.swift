//
//  NotesDelegate.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit
import CoreData

class NotesViewDelegate: NSObject, UITableViewDelegate {
    var parentViewController: UINavigationController!
    var fetchResultController: NSFetchedResultsController<Note>!
    var coreDataStack: CoreDataStack!
    
    init(navigationController: UINavigationController, fetchResultController: NSFetchedResultsController<Note>!, data: CoreDataStack) {
        super.init()
        self.parentViewController = navigationController
        self.fetchResultController = fetchResultController
        self.coreDataStack = data
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentViewController.pushViewController(UIViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavorites = UIContextualAction(style: .destructive, title: "1234567") { (_, _, _) in }
        addToFavorites.image = UIImage(systemName: "star.fill")
        addToFavorites.backgroundColor = .systemOrange
        addToFavorites.title = "Favorite"
        
        let limitAccess = UIContextualAction(style: .destructive, title: "1234567") { (_, _, _) in }
        limitAccess.image = UIImage(systemName: "lock.fill")
        limitAccess.backgroundColor = .systemGreen
        limitAccess.title = "Limit"
        
        return UISwipeActionsConfiguration(actions: [addToFavorites, limitAccess])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(style: .destructive, title: "1234567") { (_, _, _) in }
        remove.image = UIImage(systemName: "trash.fill")
        remove.backgroundColor = .systemRed
        remove.title = "To trash"
        
        let pinned = UIContextualAction(style: .normal, title: "1234567") { (_, _, _) in }
        pinned.image = UIImage(systemName: "pin.fill")
        pinned.backgroundColor = .systemBlue
        pinned.title = "Pin"
        
        let more = UIContextualAction(style: .normal, title: "1234567") { (_, _, _) in }
        more.image = UIImage(systemName: "ellipsis")
        more.backgroundColor = .systemIndigo
        more.title = "More"
        
        return UISwipeActionsConfiguration(actions: [remove, pinned, more])
    }
}
