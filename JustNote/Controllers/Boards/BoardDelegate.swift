//
//  NoteBoardsDelegate.swift
//  JustNote
//
//  Created by Максим on 15.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit
import CoreData

class BoardDelegate: NSObject, UICollectionViewDelegate {
    var parentNavigationController: UINavigationController!
    var fetchResultController: NSFetchedResultsController<Board>!
    
    init(navigationController: UINavigationController, fetchResultController: NSFetchedResultsController<Board>!) {
        super.init()
        self.parentNavigationController = navigationController
        self.fetchResultController = fetchResultController
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var indexPath = indexPath
        indexPath.section = indexPath.section - 1
        
        let board = fetchResultController.object(at: indexPath)
        let viewController: UIViewController
        
        switch board.title {
        case "Typed":
            viewController = NoteViewController()
        default:
            viewController = PasswordViewController(style: .insetGrouped)
        }
        
        viewController.title = board.title
        parentNavigationController.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
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
                
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { (UIAction) in
                print("Edit")
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: .init(), children: [lockAction, editAction, deleteAction])
        }
    }
}
