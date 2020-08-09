//
//  BoardDataSource.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/9/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BoardDataSource: NSObject, UICollectionViewDataSource {
    lazy var coreDataStack: CoreDataStack = {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               fatalError("Failed to get data stack")
           }
           return appDelegate.coreDataStack
    }()
       
    lazy var fetchResultController: NSFetchedResultsController<Board> = {
       let fetchRequest: NSFetchRequest<Board> = Board.fetchRequest()
       let sortDescriptor = NSSortDescriptor(key: #keyPath(Board.title), ascending: false)
       fetchRequest.sortDescriptors = [sortDescriptor]
       
       let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: #keyPath(Board.section), cacheName: nil)
       performFetch(controller)
       return controller
    }()
       
    private func performFetch(_ controller: NSFetchedResultsController<Board>) {
       do {
           try controller.performFetch()
       } catch {
           fatalError("Failed to performFetch: \(error)")
       }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            request.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(Note.isFavorite), true])
            let results = try! coreDataStack.managedContext.fetch(request)
            return results.count
        default:
            return fetchResultController.sections![section - 1].numberOfObjects
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderGridLayout.reuseIdentifier, for: indexPath) as! HeaderGridLayout
        header.configure(section: indexPath.section)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardFavoriteCell.reuseIdentifier, for: indexPath) as? BoardFavoriteCell else {
                fatalError("Unable to dequeue")
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionCell.reuseIdentifier, for: indexPath) as? BoardCollectionCell else {
                fatalError("Unable to dequeue")
            }
            var indexPath = indexPath
            indexPath.section = indexPath.section - 1
            cell.configure(with: fetchResultController.object(at: indexPath))
            return cell
        }
    }
}
