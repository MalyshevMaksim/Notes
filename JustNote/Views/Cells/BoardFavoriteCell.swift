//
//  BoardFavoriteCell.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/8/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class BoardFavoriteCell: UICollectionViewCell {
    static var reuseIdentifier = "BoardFavoriteCell"

    private lazy var background: UIView = {
        let background = UIView()
        background.backgroundColor = .tertiarySystemBackground
        background.layer.cornerRadius = 15
        background.layer.shadowOpacity = 0.1
        background.layer.shadowRadius = 8
        background.alpha = 0.65
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellViews() {
        contentView.addSubview(background)
    }
    
    private func setupCell() {
        setupCellViews()
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            background.topAnchor.constraint(equalTo: contentView.topAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
