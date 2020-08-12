//
//  FetchedResultController.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/9/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataController {
    lazy var fetchRequestController: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let pinnedSortDescriptor = NSSortDescriptor(key: #keyPath(Note.isPinned), ascending: false)
        fetchRequest.sortDescriptors = [pinnedSortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.instance.managedContext, sectionNameKeyPath: #keyPath(Note.section), cacheName: nil)
        performFetch(controller)
        return controller
    }()
    
    private func performFetch(_ controller: NSFetchedResultsController<Note>) {
        do {
            try controller.performFetch()
        } catch {
            fatalError("Failed to performFetch: \(error)")
        }
    }
}
