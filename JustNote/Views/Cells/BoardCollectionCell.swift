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
    
    let background = UIView()
    let title = UILabel()
    let subtitle = UILabel()
    let overlay = UIView()
    let iconCell = UIImageView()
    
    func configure(with model: NoteBoard) {
        configureBackground()
        configureTitle()
        configureSubtitle()
        configureOverlay()
        configureIconCell()
        
        title.text = model.title
        subtitle.text = model.subtitle
        overlay.backgroundColor = model.iconColor
        iconCell.image = UIImage(systemName: model.icon)
    }
    
    private func configureBackground() {
        background.backgroundColor = .secondarySystemBackground
        background.layer.cornerRadius = 10
        background.layer.shadowOpacity = 0.2
        background.layer.shadowRadius = 8
        background.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTitle() {
        title.font = .boldSystemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSubtitle() {
        subtitle.font = UIFont.preferredFont(forTextStyle: .footnote)
        subtitle.textColor = .secondaryLabel
        subtitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureOverlay() {
        overlay.layer.masksToBounds = false
        overlay.layer.cornerRadius = 10
        overlay.clipsToBounds = true
        overlay.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureIconCell() {
        iconCell.translatesAutoresizingMaskIntoConstraints = false
        iconCell.tintColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellViews() {
        contentView.addSubview(background)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        contentView.addSubview(overlay)
        contentView.addSubview(iconCell)
    }
    
    private func setupCellLayout() {
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
            
            overlay.heightAnchor.constraint(equalToConstant: 42),
            overlay.widthAnchor.constraint(equalToConstant: 42),
            overlay.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 20),
            overlay.topAnchor.constraint(equalTo: background.topAnchor,constant: 20),
            
            iconCell.heightAnchor.constraint(equalToConstant: 22),
            iconCell.widthAnchor.constraint(equalToConstant: 22),
            iconCell.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            iconCell.centerYAnchor.constraint(equalTo: overlay.centerYAnchor)
        ])
    }
}
