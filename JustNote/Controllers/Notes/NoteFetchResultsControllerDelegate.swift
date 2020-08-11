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
    var applicationData: CoreDataController!
    
    init(tableView: UITableView, with applicationData: CoreDataController) {
        self.tableView = tableView
        self.applicationData = applicationData
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let section = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(section, with: .automatic)
        case .delete:
            tableView.deleteSections(section, with: .automatic)
        case .move:
            print("MOVE!")
        case .update:
            print("UPDATE!")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            let cell = tableView.cellForRow(at: indexPath!) as! NoteCell
            let note = applicationData.controller.object(at: indexPath!)
            cell.configure(with: note)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
