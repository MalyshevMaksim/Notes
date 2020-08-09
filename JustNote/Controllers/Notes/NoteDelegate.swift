//
//  NotesDelegate.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/8/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NoteDelegate: NSObject, UITableViewDelegate {
   var fetchedResult = FetchedResultsController()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = fetchedResult.fetchResultController.object(at: indexPath)
        
        if note.isLocked {
            let action =  UIAlertController(title: "Access limited", message: "Enter password to gain access", preferredStyle: .alert)
            action.addTextField { textField in
                textField.placeholder = "Password"
                textField.isSecureTextEntry = true
            }
            action.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            action.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
        }
        else {
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionName = fetchedResult.fetchResultController.sections![section].name
        
        switch section {
        case 0:
            return HeaderNotes(title: sectionName, icon: "pin.fill", frame: CGRect())
        default:
            return HeaderNotes(title: sectionName, icon: "doc.text.fill", frame: CGRect())
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let note = fetchedResult.fetchResultController.object(at: indexPath)
        
        var pinnedAction: UIAction {
            let actionImage = UIImage(systemName: note.isPinned ? "pin.slash.fill" : "pin.fill")
            let actionTitle = note.isPinned ? "Unpin" : "pin"
            
            return UIAction(title: actionTitle, image: actionImage, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { action in
            
                if note.isPinned {
                    note.detachTag(for: "Pinned")
                    note.section = "Others"
                }
                else {
                    note.attachTag(color: .systemBlue, text: "Pinned")
                    note.section = "Pinned"
                }
                note.isPinned.toggle()
                self.fetchedResult.coreDataStack.saveContext()
            }
        }
        
        var favoriteAction: UIAction {
            let actionImage = UIImage(systemName: note.isFavorite ? "star.slash.fill" : "star.fill")
            let actionTitle = note.isFavorite ? "Remove from favorites" : "Add to favoritve"
            
            return UIAction(title: actionTitle, image: actionImage, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { action in
                
                if note.isFavorite {
                    note.detachTag(for: "Favorite")
                }
                else {
                    note.attachTag(color: .systemOrange, text: "Favorite")
                }
                note.isFavorite.toggle()
                self.fetchedResult.coreDataStack.saveContext()
            }
        }
        
        var lockAction: UIAction {
            let contextImage = UIImage(systemName: note.isLocked ? "lock.slash.fill" : "lock.fill")
            let contextTitle = note.isLocked ? "Remove limit access" : "Limit access"
            
            return UIAction(title: contextTitle, image: contextImage, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { action in
                if note.isLocked {
                    let action = UIAlertController(title: "Remove access restriction", message: "Enter password", preferredStyle: .alert)
                    action.addTextField { textFeield in
                        textFeield.placeholder = "Password"
                    }
                    
                    action.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    action.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { actions in
                        note.detachTag(for: "Protected")
                    }))
                }
                else {
                    let action = UIAlertController(title: "Access limitation", message: "Set a password for access", preferredStyle: .alert)
                    action.addTextField { textFeield in
                        textFeield.placeholder = "Create a password"
                    }
                    action.addTextField { textField in
                        textField.placeholder = "Confirm password"
                    }
                    
                    action.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    action.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { actions in
                        guard let textField = action.textFields else {
                            return
                        }
                        if textField[0].text == textField[1].text {
                            note.attachTag(color: .systemGreen, text: "Protected")
                        }
                        else {
                            
                        }
                    }))
                }
                note.isLocked.toggle()
                self.fetchedResult.coreDataStack.saveContext()
            }
        }
        
        var deleteAction: UIAction {
            return UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .off) { action in
                let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete the note?", preferredStyle: .actionSheet)
                 
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                    self.fetchedResult.coreDataStack.managedContext.delete(note)
                    self.fetchedResult.coreDataStack.saveContext()
                    
                 })
                 alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
             }
        }
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_: [UIMenuElement]) -> UIMenu? in
            return UIMenu(title: "", image: nil, identifier: nil, options: .init(), children: [pinnedAction, favoriteAction, lockAction, deleteAction])
        }
    }
}
