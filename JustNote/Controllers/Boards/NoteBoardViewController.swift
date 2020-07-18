//
//  ViewController.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit
import CoreData

struct ElementKind {
    static var headerKind = "HeaderKind"
    static var footerKind = "FooterKind"
}

class NoteBoardViewController: UICollectionViewController {
    var delegate: NoteBoardDelegate!
    
    private lazy var managedContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate!.managedContext
    }()
    
    private lazy var fetchResultController: NSFetchedResultsController<Board> = {
        let fetchRequest: NSFetchRequest<Board> = Board.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Board.numberOfNotes), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try controller.performFetch()
        } catch {
            fatalError("###\(#function): Failed to performFetch: \(error)")
        }
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadSampleData(loader: SampleDataLoader(strategy: LoadingSampleBoard(context: managedContext)))
        configureController()
        configureCollectionView()
    }
    
    private func loadSampleData(loader: SampleDataLoader) {
        // If the application is launched for the first time
        if loader.notApplicationLaunched() {
            loader.loadData(path: "SampleFolders", type: "plist")
        }
    }
    
    private func configureController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        navigationItem.searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureCollectionView() {
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .none
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        configureHierarchy()
        delegate = NoteBoardDelegate(navigationController: navigationController!)
        collectionView.delegate = delegate
    }
    
    private func configureHierarchy() {
        collectionView.register(BoardCollectionCell.self, forCellWithReuseIdentifier: BoardCollectionCell.reuseIdentifier)
        collectionView.register(HeaderGridLayout.self, forSupplementaryViewOfKind: ElementKind.headerKind, withReuseIdentifier: HeaderGridLayout.reuseIdentifier)
        collectionView.collectionViewLayout = setupGridLayout()
    }
}

extension NoteBoardViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultController.sections![section].numberOfObjects
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderGridLayout.reuseIdentifier, for: indexPath) as! HeaderGridLayout
        header.configure()
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionCell.reuseIdentifier, for: indexPath) as? BoardCollectionCell else {
            fatalError("Unable to dequeue")
        }
        cell.configure(with: fetchResultController.object(at: indexPath))
        return cell
    }
}
