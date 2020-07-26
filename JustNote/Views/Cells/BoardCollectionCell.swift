//
//  NotesCollectionCell.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class BoardCollectionCell: UICollectionViewCell {
    static var reuseIdentifier = "NotesCollectionCell"
    
    func configure(with model: Board) {
        title.text = model.title
        subtitle.text = "\(model.numberOfNotes) notes"
        overlay.backgroundColor = model.tintColor
        iconCell.image = UIImage(systemName: model.iconName!)
        textOverlay.backgroundColor = model.tintColor
    }
    
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
    
    private lazy var textOverlay: UIView = {
        let textOverlay = UIView()
        textOverlay.alpha = 0.03
        textOverlay.layer.cornerRadius = 10
        textOverlay.translatesAutoresizingMaskIntoConstraints = false
        return textOverlay
    }()

    private lazy var title: UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 16)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont.preferredFont(forTextStyle: .footnote)
        subtitle.textColor = .secondaryLabel
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    
    private lazy var overlay: UIView = {
        let overlay = UIView()
        overlay.layer.masksToBounds = false
        overlay.layer.cornerRadius = 10
        overlay.clipsToBounds = true
        overlay.translatesAutoresizingMaskIntoConstraints = false
        return overlay
    }()
    
    private lazy var iconCell: UIImageView = {
        let iconCell = UIImageView()
        iconCell.translatesAutoresizingMaskIntoConstraints = false
        iconCell.tintColor = .white
        return iconCell
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
        contentView.addSubview(textOverlay)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        contentView.addSubview(overlay)
        contentView.addSubview(iconCell)
    }
    
    private func setupCell() {
        setupCellViews()
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            background.topAnchor.constraint(equalTo: contentView.topAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            
            textOverlay.heightAnchor.constraint(equalToConstant: 62),
            textOverlay.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 10),
            textOverlay.trailingAnchor.constraint(equalTo: background.trailingAnchor,constant: -10),
            textOverlay.bottomAnchor.constraint(equalTo: background.bottomAnchor,constant: -10),
            
            overlay.heightAnchor.constraint(equalToConstant: 38),
            overlay.widthAnchor.constraint(equalToConstant: 38),
            overlay.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 20),
            overlay.topAnchor.constraint(equalTo: background.topAnchor,constant: 18),
            
            iconCell.heightAnchor.constraint(equalToConstant: 21),
            iconCell.widthAnchor.constraint(equalToConstant: 21),
            iconCell.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            iconCell.centerYAnchor.constraint(equalTo: overlay.centerYAnchor)
        ])
    }
}
