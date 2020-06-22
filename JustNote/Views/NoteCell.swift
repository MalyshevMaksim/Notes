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
        date.text = model.date
        
        for item in 0..<model.tags.count {
            let tag = TagView(type: model.tags[item], frame: CGRect())
            itemStack.addArrangedSubview(tag)
        }
    }
    
    lazy var texts: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    lazy var itemStack: UIStackView = {
        let tag1 = TagView(type: .favorite, frame: CGRect())
        
        let stack = UIStackView(arrangedSubviews: [])
        stack.spacing = 6
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    func getCellHeight() -> CGFloat {
        return itemStack.bounds.height
    }
    
    private func setupCell() {
        contentView.addSubview(texts)
        contentView.addSubview(titlese)
        contentView.addSubview(date)
        contentView.addSubview(itemStack)
        
        NSLayoutConstraint.activate([
            itemStack.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 0.5),
            itemStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            itemStack.heightAnchor.constraint(equalToConstant: 20),
            
            titlese.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: itemStack.lastBaselineAnchor, multiplier: 1),
            titlese.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titlese.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            texts.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: titlese.lastBaselineAnchor, multiplier: 1.2),
            texts.leadingAnchor.constraint(equalTo: titlese.leadingAnchor),
            texts.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            date.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: texts.lastBaselineAnchor, multiplier: 1.1),
            date.leadingAnchor.constraint(equalTo: titlese.leadingAnchor),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: date.lastBaselineAnchor, multiplier: 0.5)
        ])
    }
}
