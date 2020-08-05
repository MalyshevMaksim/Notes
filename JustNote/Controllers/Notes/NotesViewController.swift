//
//  NotesViewController.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController {
    var delegate: NotesViewDelegate?
    var key: String?
    
    lazy var coreDataStack: CoreDataStack = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Failed to get data stack")
        }
        return appDelegate.coreDataStack
    }()
    
    private lazy var fetchResultController: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Note.date), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(Note.board.title), key!])
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        performFetch(controller)
        controller.delegate = self
        return controller
    }()
    
    private func performFetch(_ controller: NSFetchedResultsController<Note>) {
        do {
            try controller.performFetch()
        } catch {
            fatalError("Failed to performFetch: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Typed"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let loader = SampleDataLoader(path: "SampleNotes", type: "plist")
        loader.load(with: SampleNoteLoader(), to: coreDataStack)
        
        configureTableView()
        configureController()
    }
    
    private func configureTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.backgroundColor = .secondarySystemBackground
        tableView.delegate = self
    }
    
    private func configureController() {
        navigationItem.searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(setEditMode))
    }
    
    private func updateLeftBarButton() {
       if tableView.isEditing == true {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setEditMode))
       }
       else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(setEditMode))
            tabBarController?.tabBar.isHidden = false
       }
    }
    
    @objc func setEditMode() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.style = tableView.isEditing ? .done : .plain
        updateLeftBarButton()
    }
}

extension NotesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell else {
            fatalError("Error: Unable to dequeue")
        }
        cell.configure(with: fetchResultController.object(at: indexPath))
        return cell
    }
}

extension NotesViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        default:
            print("")
        }
    }
}

extension NotesViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return HeaderNotes(title: "Pinned", icon: "pin.fill", frame: CGRect())
        default:
            return HeaderNotes(title: "Swift", icon: "desktopcomputer", frame: CGRect())
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
         return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_: [UIMenuElement]) -> UIMenu? in
                   
                   let lockAction = UIAction(title: "Limit access", image: UIImage(systemName: "lock.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { (UIAction) in
                       print("locked")
                   })
                   
                   let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .off) { (UIAction) in
                       
                           let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete the note?", preferredStyle: .actionSheet)
                           
                           alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: "Default action"), style: .destructive, handler: { _ in
                   
                               let note = self.fetchResultController.object(at: indexPath)
                               self.coreDataStack.managedContext.delete(note)
                               self.coreDataStack.saveContext()
                           }))
                       
                           alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
                           
                           }))
                    self.present(alert, animated: true, completion: nil)
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
}
