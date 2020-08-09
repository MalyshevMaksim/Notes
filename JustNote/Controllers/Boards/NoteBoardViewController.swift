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
    var delegate: BoardDelegate!
    var dataSource: BoardDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureController()
        configureCollectionView()
        
        let loader = SampleDataLoader(path: "SampleBoards", type: "plist")
        loader.load(with: SampleBoardLoader(), to: dataSource.coreDataStack)
        
        let loaderm = SampleDataLoader(path: "SampleNotes", type: "plist")
        loaderm.load(with: SampleNoteLoader(), to: dataSource.coreDataStack)
    }
    
    private func configureController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        navigationItem.searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureCollectionView() {
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        configureHierarchy()
        dataSource = BoardDataSource()
        delegate = BoardDelegate(navigationController: self.navigationController!, fetchResultController: dataSource.fetchResultController)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    private func configureHierarchy() {
        collectionView.register(BoardCollectionCell.self, forCellWithReuseIdentifier: BoardCollectionCell.reuseIdentifier)
        collectionView.register(HeaderGridLayout.self, forSupplementaryViewOfKind: ElementKind.headerKind, withReuseIdentifier: HeaderGridLayout.reuseIdentifier)
        collectionView.register(BoardFavoriteCell.self, forCellWithReuseIdentifier: BoardFavoriteCell.reuseIdentifier)
        collectionView.collectionViewLayout = setupGridLayout()
    }
}
