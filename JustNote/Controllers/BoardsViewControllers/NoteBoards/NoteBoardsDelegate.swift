//
//  NoteBoardsDelegate.swift
//  JustNote
//
//  Created by Максим on 15.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

extension NoteBoardsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_: [UIMenuElement]) -> UIMenu? in
            
            let lockAction = UIAction(title: "Limit access", image: UIImage(systemName: "lock.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { (UIAction) in
                print("locked")
            })
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .off) { (UIAction) in
                    print("Delete")
                }
                
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { (UIAction) in
                print("Edit")
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: .init(), children: [lockAction, editAction, deleteAction])
        }
    }
}
