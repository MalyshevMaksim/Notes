//
//  NotesCollectionCell.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NotesCollectionCell: UICollectionViewCell {
    static var reuseIdentifier = "NotesCollectionCell"
    
    var cellBackground: UIView = {
        let background = UIView()
        background.backgroundColor = #colorLiteral(red: 0.08817935735, green: 0.09153553098, blue: 0.106112428, alpha: 1)
        background.layer.cornerRadius = 20
        background.layer.borderWidth = 0.2
        background.layer.borderColor = #colorLiteral(red: 0.1803921569, green: 0.1843137255, blue: 0.2039215686, alpha: 1)
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    var iconOverlay: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = .systemPink
        overlay.layer.masksToBounds = false
        overlay.layer.cornerRadius = 22.5
        overlay.clipsToBounds = true
        overlay.translatesAutoresizingMaskIntoConstraints = false
        return overlay
    }()
    
    var iconPerCell: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "mic.fill"), highlightedImage: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "Audio"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subtitle: UILabel = {
        let label = UILabel()
        label.text = "5 notes"
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsForCell()
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewsForCell() {
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
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor)
        ])
    }
}
