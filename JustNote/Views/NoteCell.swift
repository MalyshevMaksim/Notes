//
//  NoteCell.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    static var reuseIdentifier = "NoteCell"
    
    func configure(with model: Note) {
        texts.text = model.text
        titlese.text = model.title
        date.text = "24 ноября 2019"
    }
    
    lazy var texts: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    lazy var titlese: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var date: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(texts)
        contentView.addSubview(titlese)
        contentView.addSubview(date)
        
        NSLayoutConstraint.activate([
            titlese.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titlese.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            texts.topAnchor.constraint(equalTo: titlese.bottomAnchor, constant: 5),
            texts.leadingAnchor.constraint(equalTo: titlese.leadingAnchor),
            texts.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            date.topAnchor.constraint(equalTo: texts.bottomAnchor, constant: 5),
            date.leadingAnchor.constraint(equalTo: titlese.leadingAnchor),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
