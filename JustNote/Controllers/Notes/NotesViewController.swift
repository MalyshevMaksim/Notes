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
    var key: String?
    
    private lazy var coreDataStack: CoreDataStack = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Failed to get data stack")
        }
        return appDelegate.coreDataStack
    }()
    
    private lazy var fetchResultController: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        let pinnedSortDescriptor = NSSortDescriptor(key: #keyPath(Note.isPinned), ascending: false)
        
        fetchRequest.sortDescriptors = [pinnedSortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(Note.board.title), key!])
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: #keyPath(Note.section), cacheName: nil)
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
        title = key
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
        tableView.backgroundColor = .systemBackground
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
        return fetchResultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections?[section].numberOfObjects ?? 0
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
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let section = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(section, with: .automatic)
        case .delete:
            tableView.deleteSections(section, with: .automatic)
        case .move:
            print("MOVE")
        case .update:
            print("UPDATE")
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
            print("UPDATE!")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

extension NotesViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionName = fetchResultController.sections![section].name
        
        switch section {
        case 0:
            return HeaderNotes(title: sectionName, icon: "pin.fill", frame: CGRect())
        default:
            return HeaderNotes(title: sectionName, icon: "doc.text.fill", frame: CGRect())
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let note = self.fetchResultController.object(at: indexPath)
        
        var pinnedAction: UIAction {
            let actionImage = UIImage(systemName: note.isPinned ? "pin.slash.fill" : "pin.fill")
            let actionTitle = note.isPinned ? "Unpin" : "pin"
            
            return UIAction(title: actionTitle, image: actionImage, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { action in
            
                if note.isPinned {
                    note.removeTag(for: "Pinned")
                    note.section = "Others"
                }
                else {
                    note.addTag(color: .systemBlue, text: "Pinned", to: self.coreDataStack)
                    note.section = "Pinned"
                }
                note.isPinned.toggle()
                self.coreDataStack.saveContext()
            }
        }
        
        var favoriteAction: UIAction {
            let actionImage = UIImage(systemName: note.isFavorite ? "star.slash.fill" : "star.fill")
            let actionTitle = note.isFavorite ? "Remove from favorites" : "Add to favoritve"
            
            return UIAction(title: actionTitle, image: actionImage, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { action in
                
                if note.isFavorite {
                    note.removeTag(for: "Favorite")
                }
                else {
                    note.addTag(color: .systemOrange, text: "Favorite", to: self.coreDataStack)
                }
                note.isFavorite.toggle()
                self.coreDataStack.saveContext()
            }
        }
        
        var lockAction: UIAction {
            let contextImage = UIImage(systemName: note.isLocked ? "lock.slash.fill" : "lock.fill")
            let contextTitle = note.isLocked ? "Remove limit access" : "Limit access"
            
            return UIAction(title: contextTitle, image: contextImage, identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { action in
                if note.isLocked {
                    note.removeTag(for: "Protected")
                }
                else {
                    note.addTag(color: .systemGreen, text: "Protected", to: self.coreDataStack)
                }
                note.isLocked.toggle()
                self.coreDataStack.saveContext()
            }
        }
        
        var deleteAction: UIAction {
            return UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .off) { action in
                let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete the note?", preferredStyle: .actionSheet)
                 
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                    self.coreDataStack.managedContext.delete(note)
                    self.coreDataStack.saveContext()
                 })
                 alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                 self.present(alert, animated: true, completion: nil)
             }
        }
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_: [UIMenuElement]) -> UIMenu? in
            return UIMenu(title: "", image: nil, identifier: nil, options: .init(), children: [pinnedAction, favoriteAction, lockAction, deleteAction])
        }
    }
}
