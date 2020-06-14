//
//  ViewController.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        configureTabBar()
        configureCollectionView()
    }
    
    private func configureTabBar() {
        tabBarItem = UITabBarItem(title: "Notes", image: UIImage(systemName: "pencil.tip.crop.circle"), selectedImage: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCompositionalLayout())
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .none
        collectionView.register(NotesCollectionCell.self, forCellWithReuseIdentifier: NotesCollectionCell.reuseIdentifier)
        
        view.addSubview(collectionView)
    }
}

// MARK: Setup layout for collectionView

extension NotesViewController {
    private func setupCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(section: createSection())
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: createGroup())
        return section
    }
    
    private func createGroup() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [createItem()])
        return groupLayout
    }
    
    private func createItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        return itemLayout
    }
}

// MARK: Setup dataSoutce for collectionView

extension NotesViewController {
    private func createSnapshotForDataSource() -> NSDiffableDataSourceSnapshot<Int, Int> {
        let snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        return snapshot
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView, indexPath, Identifer) -> UICollectionViewCell? in
            
            let notesCell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCollectionCell.reuseIdentifier, for: indexPath) as! NotesCollectionCell
            return notesCell
        }
        
        dataSource.apply(createSnapshotForDataSource(), animatingDifferences: true)
    }
}
