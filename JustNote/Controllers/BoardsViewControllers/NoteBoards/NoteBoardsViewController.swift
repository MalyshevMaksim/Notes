//
//  ViewController.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NoteBoardsViewController: UICollectionViewController {
    var sections = [BoardSection(id: 0, title: "", subtitle: "", type: "defaultBoardings", items: bordersOfNotes)]
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
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .none
        collectionView.register(BoardCollectionCell.self, forCellWithReuseIdentifier: BoardCollectionCell.reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = makeDataSource()
        collectionView.delegate = self
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
        
        isGridLayout.toggle()
        navigationItem.leftBarButtonItem?.image = isGridLayout ? UIImage(systemName: "rectangle.grid.1x2") : UIImage(systemName: "square.grid.2x2")
    }
}
