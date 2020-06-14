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
        configureTabBarItem()
        configureCollectionView()
    }
    
    private func configureTabBarItem() {
        tabBarItem = UITabBarItem(title: "Notes", image: UIImage(systemName: "pencil.tip.crop.circle"), selectedImage: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCompositionalLayout())
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .none
        collectionView.register(NotesCollectionCell.self, forCellWithReuseIdentifier: NotesCollectionCell.reuseIdentifier)
        
        setupDataSource()
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [createItem()])
        return groupLayout
    }
    
    private func createItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        return itemLayout
    }
}

// MARK: Setup dataSoutce for collectionView

extension NotesViewController {
    private func createSnapshotForDataSource() -> NSDiffableDataSourceSnapshot<Int, Int> {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        
        for item in 0..<2 {
            snapshot.appendItems([item])
        }
        return snapshot
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView, indexPath, Identifer) -> UICollectionViewCell? in
            
            switch indexPath.item {
            case 0:
                let textNotes = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCollectionCell.reuseIdentifier, for: indexPath) as! NotesCollectionCell
                textNotes.iconPerCell.image = UIImage(systemName: "pencil")
                textNotes.iconOverlay.backgroundColor = .systemBlue
                textNotes.title.text = "Text"
                textNotes.subtitle.text = "12 notes"
                return textNotes
            default:
                let audioNotes = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCollectionCell.reuseIdentifier, for: indexPath) as! NotesCollectionCell
                return audioNotes
            }
        }
        
        dataSource.apply(createSnapshotForDataSource(), animatingDifferences: true)
    }
}

// MARK: Setup delegate for collectionView

extension NotesViewController: UICollectionViewDelegate {
    
}
