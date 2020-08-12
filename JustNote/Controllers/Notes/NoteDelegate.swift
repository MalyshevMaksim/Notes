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
import LocalAuthentication
import Dispatch

class NoteDelegate: NSObject, UITableViewDelegate {
    var viewController: NoteViewController!

    private func biometricAuthentication(completed: @escaping (_ success: Bool) -> ()) {
        let contxt = LAContext()
            if contxt.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                contxt.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to proceed.") { success, error in
                    completed(success)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = viewController.applicationData.fetchRequestController.object(at: indexPath)
        
        if note.isLocked {
            biometricAuthentication { success in
                if success {
                    DispatchQueue.main.async {
                        self.viewController.navigationController?.pushViewController(UIViewController(), animated: true)
                    }
                }
            }
        }
        else {
            viewController.navigationController?.pushViewController(UIViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionName = viewController.applicationData.fetchRequestController.sections![section].name
        
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
        let note = viewController.applicationData.fetchRequestController.object(at: indexPath)
        
        var pinningAction: UIAction {
            let title = note.isPinned ? "Unpin" : "pin"
            let icon = UIImage(systemName: note.isPinned ? "pin.slash.fill" : "pin.fill")
            
            return UIAction(title: title, image: icon, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { action in
                if note.isPinned {
                    note.detachTag(for: "Pinned")
                    note.section = "Others"
                }
                else {
                    note.attachTag(color: .systemBlue, text: "Pinned")
                    note.section = "Pinned"
                }
                note.isPinned.toggle()
                CoreDataStack.instance.saveContext()
            }
        }
        
        var addToFavoriteAction: UIAction {
            let title = note.isFavorite ? "Remove from favorites" : "Add to favoritve"
            let icon = UIImage(systemName: note.isFavorite ? "star.slash.fill" : "star.fill")
            
            return UIAction(title: title, image: icon, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { action in
                if note.isFavorite {
                    note.detachTag(for: "Favorite")
                }
                else {
                    note.attachTag(color: .systemOrange, text: "Favorite")
                }
                note.isFavorite.toggle()
                CoreDataStack.instance.saveContext()
            }
        }
        
        var deleteAction: UIAction {
            return UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive,    state: .off) { action in
                let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete the note?", preferredStyle: .actionSheet)
                
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                     CoreDataStack.instance.managedContext.delete(note)
                     CoreDataStack.instance.saveContext()
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                self.viewController.present(alert, animated: true, completion: nil)
            }
        }
        
        var accessLimitAction: UIAction {
            let title = note.isLocked ? "Remove limit access" : "Limit access"
            let icon = UIImage(systemName: note.isLocked ? "lock.slash.fill" : "lock.fill")
            
            return UIAction(title: title, image: icon, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { action in
                if note.isLocked {
                    self.biometricAuthentication { success in
                        if success {
                            note.detachTag(for: "Protected")
                            note.isLocked.toggle()
                             CoreDataStack.instance.saveContext()
                        }
                    }
                }
                else {
                    note.attachTag(color: .systemGreen, text: "Protected")
                    note.isLocked.toggle()
                    CoreDataStack.instance.saveContext()
                }
            }
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_: [UIMenuElement]) -> UIMenu? in
            return UIMenu(title: "", image: nil, identifier: nil, options: .init(), children: [pinningAction, addToFavoriteAction, accessLimitAction, deleteAction])
        }
    }
}
