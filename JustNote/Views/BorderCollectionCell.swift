//
//  NotesCollectionCell.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class BorderCollectionCell: UICollectionViewCell {
    static var reuseIdentifier = "NotesCollectionCell"
    
    private var isLocked = false {
        didSet {
            lockHandler()
        }
    }
    
    private func lockHandler() {
        lockIcon.alpha = isLocked ? 1.0 : 0.0
    }
    
    var borderOfNotesModel: NoteBorder? {
        didSet {
            guard let border = borderOfNotesModel else {
                return
            }
            
            title.text = border.title
            iconPerCell.image = UIImage(systemName: border.icon)
            subtitle.text = border.subtitle
            isLocked = border.isLocked
            iconOverlay.backgroundColor = border.iconColor
        }
    }
    
    lazy var lockIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "lock.fill"))
        icon.tintColor = .systemRed
        icon.alpha = isLocked ? 1.0 : 0.0
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var cellBackground: UIView = {
        let background = UIView()
        background.backgroundColor = #colorLiteral(red: 0.1150090769, green: 0.1185865179, blue: 0.1396087408, alpha: 1)
        background.layer.cornerRadius = 20
        background.layer.borderWidth = 0.2
        background.layer.borderColor = #colorLiteral(red: 0.1803921569, green: 0.1843137255, blue: 0.2039215686, alpha: 1)
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    lazy var iconOverlay: UIView = {
        let overlay = UIView()
        overlay.layer.masksToBounds = false
        overlay.layer.cornerRadius = 13
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
        contentView.addSubview(lockIcon)
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
            
            lockIcon.centerYAnchor.constraint(equalTo: subtitle.centerYAnchor),
            lockIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
}
