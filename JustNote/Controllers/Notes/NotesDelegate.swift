//
//  NotesDelegate.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NotesViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pinned = UIContextualAction(style: .destructive, title: "1234567") { (_, _, _) in }
         pinned.image = UIImage(systemName: "pin.fill")
         pinned.backgroundColor = .systemBlue
         pinned.title = "Pin"
        
        let addToFavorites = UIContextualAction(style: .destructive, title: "1234567") { (_, _, _) in }
        addToFavorites.image = UIImage(systemName: "star.fill")
        addToFavorites.backgroundColor = .systemOrange
        addToFavorites.title = "Favorite"
        
        return UISwipeActionsConfiguration(actions: [pinned, addToFavorites])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let limitAccess = UIContextualAction(style: .destructive, title: "1234567") { (_, _, _) in }
         limitAccess.image = UIImage(systemName: "lock.fill")
        limitAccess.backgroundColor = .systemGreen
         limitAccess.title = "Limit"
        
        let remove = UIContextualAction(style: .destructive, title: "1234567") { (_, _, _) in }
        remove.image = UIImage(systemName: "trash.fill")
        remove.backgroundColor = .systemRed
        remove.title = "To trash"
        
        return UISwipeActionsConfiguration(actions: [remove, limitAccess])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_: [UIMenuElement]) -> UIMenu? in
            
            let lockAction = UIAction(title: "Limit access", image: UIImage(systemName: "lock.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { (UIAction) in
                print("locked")
            })
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .off) { (UIAction) in
                
                    let alert = UIAlertController(title: "Warning", message:
                    "Are you sure you want to delete all notes in this folder? You can restore notes within 7 days after deletion.", preferredStyle: .actionSheet)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: "Default action"), style: .destructive, handler: { _ in
                        
                    }))
                
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
                    
                    }))
                }
                
            let favoriteAction = UIAction(title: "Add to favorites", image: UIImage(systemName: "star.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { (UIAction) in
                print("Edit")
            }
            
            let pinnedAction = UIAction(title: "Pin", image: UIImage(systemName: "pin.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { (UIAction) in
                print("Edit")
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: .init(), children: [pinnedAction, favoriteAction, lockAction, deleteAction])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
