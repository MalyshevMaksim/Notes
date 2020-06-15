//
//  ViewController.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NoteBoardsViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    private var isGridLayout = true

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        configureLeftBarButton()
        configureRightBarButton()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupGridLayout())
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .none
        collectionView.register(BorderCollectionCell.self, forCellWithReuseIdentifier: BorderCollectionCell.reuseIdentifier)
        
        let delegate = NoteBoardsDelegate()
        collectionView.delegate = delegate
        
        collectionView.dataSource = dataSource
        
        view.addSubview(collectionView)
    }
    
    private func configureRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    private func configureLeftBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeEditMode))
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        guard isEditing != editing else {
            return
        }
        super.setEditing(editing, animated: true)
        navigationItem.leftBarButtonItem?.style = isEditing ? .done : .plain
    }
    
    @objc private func changeEditMode() {
        setEditing(!isEditing, animated: true)
        
        let layout = isGridLayout ? setupLineLayout() : setupGridLayout()
        isGridLayout.toggle()
        collectionView.setCollectionViewLayout(layout, animated: true)
        navigationItem.leftBarButtonItem?.image = isGridLayout ? UIImage(systemName: "rectangle.grid.1x2") : UIImage(systemName: "square.grid.2x2")
    }
}

// MARK: Setup grid layout for collectionView

extension NoteBoardsViewController {
    private func setupGridLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(section: createSection())
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: createGroup())
        return section
    }
    
    private func createGroup() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.4))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [createItem()])
        return groupLayout
    }
    
    private func createItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return itemLayout
    }
}

extension NoteBoardsViewController {
    private func setupLineLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(section: createLineSection())
        return layout
    }
    
    private func createLineSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: createLineGroup())
        return section
    }
    
    private func createLineGroup() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.4))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [createLineItem()])
        return groupLayout
    }
    
    private func createLineItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6)
        return itemLayout
    }
}

extension NoteBoardsViewController {
    
    private func setupDataSource() {
        guard let collectionView = collectionView else {
            return
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, Identifer) -> UICollectionViewCell? in
            return self.setupCellWith(indexPathForCell: indexPath)
        }
        dataSource!.apply(makeSnapshot(), animatingDifferences: true)
    }
    
    private func setupCellWith(indexPathForCell: IndexPath) -> UICollectionViewCell {
        guard let collectionView = collectionView else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BorderCollectionCell.reuseIdentifier, for: indexPathForCell) as! BorderCollectionCell
        cell.borderOfNotesModel = bordersOfNotes[indexPathForCell.item]
        return cell
    }
    
    private func makeSnapshot() -> DataSourceSnapshot {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])
        
        for item in 0..<bordersOfNotes.count {
            snapshot.appendItems([item])
        }
        return snapshot
    }
}

