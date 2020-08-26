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
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
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
            case .update:
                let cell = tableView.cellForRow(at: indexPath!) as! NoteCell
                let note = CoreDataStack.shared.fetchRequestController.object(at: indexPath!)
                cell.configureTagStack(with: note)
            case .move:
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
                let cell = tableView.cellForRow(at: indexPath!) as! NoteCell
                let note = CoreDataStack.shared.fetchRequestController.object(at: newIndexPath!)
                cell.configureTagStack(with: note)
            default:
                break
        }
    }
}
