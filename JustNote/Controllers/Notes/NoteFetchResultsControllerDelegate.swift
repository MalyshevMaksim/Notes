//
//  NoteFetchResultsControllerDelegate.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/11/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NoteFetchResultsControllerDelegate: NSObject, NSFetchedResultsControllerDelegate {
    var tableView: UITableView!
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let section = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(section, with: .fade)
        case .delete:
            tableView.deleteSections(section, with: .fade)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            let note = CoreDataStack.shared.fetchRequestController.object(at: indexPath!)
            let cell = self.tableView.cellForRow(at: indexPath!) as! NoteCell
            cell.configure(with: note)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
