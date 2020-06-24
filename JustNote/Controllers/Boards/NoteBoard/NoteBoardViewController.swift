//
//  ViewController.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

struct ElementKind {
    static var headerKind = "HeaderKind"
    static var footerKind = "FooterKind"
}

class NoteBoardViewController: UICollectionViewController {
    var dataSource: NoteBoardDataSource!
    var delegate: NoteBoardDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureController()
        configureCollectionView()
        configureDataSource()
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
    
    func configureDataSource()  {
        dataSource = NoteBoardDataSource(collectionView: collectionView) {
            (collectionView, indexPath, board) -> UICollectionViewCell? in
            
            switch sections[indexPath.section].type {
            case "defaultBoardings":
                return self.configureCell(with: board, for: indexPath)
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    private func configureCell(with noteBoarding: NoteBoard, for indexPath: IndexPath) -> BoardCollectionCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionCell.reuseIdentifier, for: indexPath) as? BoardCollectionCell else {
            fatalError("Unable to dequeue")
        }
        cell.configure(with: noteBoarding)
        return cell
    }
}
