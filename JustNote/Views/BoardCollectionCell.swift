//
//  NotesCollectionCell.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class BoardCollectionCell: UICollectionViewCell, ConfiguringCell {
    static var reuseIdentifier = "NotesCollectionCell"
    
    func configure(with model: NoteBoard) {
        title.text = model.title
        iconPerCell.image = UIImage(systemName: model.icon)
        subtitle.text = model.subtitle
        iconOverlay.backgroundColor = model.iconColor
    }
    
    lazy var cellBackground: UIView = {
        let background = UIView()
        background.backgroundColor = .secondarySystemBackground
        background.layer.cornerRadius = 10
        background.layer.shadowOpacity = 0.2
        background.layer.shadowRadius = 8
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    lazy var iconOverlay: UIView = {
        let overlay = UIView()
        overlay.layer.masksToBounds = false
        overlay.layer.cornerRadius = 10
        overlay.clipsToBounds = true
        overlay.translatesAutoresizingMaskIntoConstraints = false
        return overlay
    }()
    
    lazy var iconPerCell: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "mic.fill"), highlightedImage: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellViews()
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellViews() {
        contentView.addSubview(cellBackground)
        contentView.addSubview(iconOverlay)
        contentView.addSubview(iconPerCell)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
    }
    
    private func setupCellLayout() {
        NSLayoutConstraint.activate([
            cellBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            iconOverlay.heightAnchor.constraint(equalToConstant: 42),
            iconOverlay.widthAnchor.constraint(equalToConstant: 42),
            iconOverlay.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor,constant: 20),
            iconOverlay.topAnchor.constraint(equalTo: cellBackground.topAnchor,constant: 20),
            
            iconPerCell.heightAnchor.constraint(equalToConstant: 22),
            iconPerCell.widthAnchor.constraint(equalToConstant: 22),
            iconPerCell.centerXAnchor.constraint(equalTo: iconOverlay.centerXAnchor),
            iconPerCell.centerYAnchor.constraint(equalTo: iconOverlay.centerYAnchor),
            
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
        ])
    }
}
