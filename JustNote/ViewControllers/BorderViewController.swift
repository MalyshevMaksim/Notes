//
//  ViewController.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class BorderViewController: UIViewController {
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
        collectionView.delegate = self
        
        setupDataSource()
        view.addSubview(collectionView)
    }
    
    private func configureRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    private func configureLeftBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "rectangle.grid.1x2")
        navigationItem.leftBarButtonItem?.action = #selector(changeLayout)
    }
    
    @objc private func changeLayout() {
        let layout = isGridLayout ? setupLineLayout() : setupGridLayout()
        isGridLayout.toggle()
        collectionView.setCollectionViewLayout(layout, animated: true)
        navigationItem.leftBarButtonItem?.image = isGridLayout ? UIImage(systemName: "rectangle.grid.1x2") : UIImage(systemName: "square.grid.2x2")
    }
}

// MARK: Setup grid layout for collectionView

extension BorderViewController {
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

extension BorderViewController {
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
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        return itemLayout
    }
}

// MARK: Setup diffable dataSoutce for collectionView

extension BorderViewController {
    typealias DataSourceSnapshor = NSDiffableDataSourceSnapshot<Int, Int>
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>
    
    private func createSnapshotForDataSource() -> DataSourceSnapshor {
        var snapshot = DataSourceSnapshor()
        snapshot.appendSections([0])
        
        for item in 0..<4 {
            snapshot.appendItems([item])
        }
        
        return snapshot
    }
    
    private func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, Identifer) -> UICollectionViewCell? in
            return self.setupCellWith(indexPathForCell: indexPath)
        }
        
        dataSource.apply(createSnapshotForDataSource(), animatingDifferences: true)
    }
    
    private func setupCellWith(indexPathForCell: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BorderCollectionCell.reuseIdentifier, for: indexPathForCell) as! BorderCollectionCell
        cell.borderOfNotesModel = bordersOfNotes[indexPathForCell.item]
        return cell
    }
}

// MARK: Setup delegate for collectionView

extension BorderViewController: UICollectionViewDelegate {
    private func makeDetailsViewController() -> UIViewController {
        return FavoritesViewController()
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: makeDetailsViewController) { (_: [UIMenuElement]) -> UIMenu? in
            
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { (UIAction) in
                print("share")
            })
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .off) { (UIAction) in
                    print("Delete")
                }
                
            let editAction = UIAction(title: "Edit..", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off) { (UIAction) in
                print("Edit")
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: .init(), children: [shareAction, editAction, deleteAction])
        }
    }
}
