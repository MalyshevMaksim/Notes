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
        
        loadSampleBoard()
        configureController()
        configureCollectionView()
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
    
    private func loadSampleBoard() {
        guard let filePath = Bundle.main.path(forResource: "SampleFolders", ofType: "plist"),
              let boards = NSArray(contentsOfFile: filePath) else {
            fatalError("")
        }
        
        if !UserDefaults.standard.bool(forKey: "isFirstStart") {
            for board in boards {
                let resultingDictionary = board as? [String : Any]
                configureBoard(resultingDictionary!)
            }
            try! managedContext.save()
            UserDefaults.standard.set(true, forKey: "isFirstStart")
        }
    }
    
    private func configureBoard(_ boardDictionary: [String : Any]) {
        let board = Board(context: managedContext)
        board.title = boardDictionary["title"] as? String
        board.numberOfNotes = boardDictionary["numberOfNotes"] as! Int16
        board.iconName = boardDictionary["iconName"] as? String
        board.tintColor = UIColor.color(dict: boardDictionary["tintColor"] as! [String : Any])!
    }
}

extension NoteBoardViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultController.sections![section].numberOfObjects
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionCell.reuseIdentifier, for: indexPath) as? BoardCollectionCell else {
            fatalError("Unable to dequeue")
        }
        cell.configure(with: fetchResultController.object(at: indexPath))
        return cell
    }
}

private extension UIColor {
    static func color(dict: [String : Any]) -> UIColor? {
        guard let red = dict["red"] as? NSNumber,
              let green = dict["green"] as? NSNumber,
              let blue = dict["blue"] as? NSNumber else {
            return nil
        }
        return UIColor(red: CGFloat(truncating: red) / 255.0, green: CGFloat(truncating: green) / 255.0, blue: CGFloat(truncating: blue) / 255.0, alpha: 1)
    }
}
