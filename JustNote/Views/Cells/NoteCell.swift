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
    var tagStack = UIStackView()
    
    func configure(with model: Note) {
        title.text = model.title
        body.text = model.body
        lastModifiedDate.text = dateFormatter.string(from: model.date!)
        //tagStack = model.tagStack
        backgroundColor = .secondarySystemBackground
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter
    }()
    
    private lazy var title: UILabel = {
        let noteTitle = UILabel()
        noteTitle.font = UIFont.boldSystemFont(ofSize: 20)
        noteTitle.translatesAutoresizingMaskIntoConstraints = false
        return noteTitle
    }()
    
    private lazy var body: UILabel = {
        let noteBody = UILabel()
        noteBody.font = UIFont.preferredFont(forTextStyle: .callout)
        noteBody.translatesAutoresizingMaskIntoConstraints = false
        noteBody.lineBreakMode = .byTruncatingTail
        noteBody.numberOfLines = 2
        return noteBody
    }()
    
    private lazy var lastModifiedDate: UILabel = {
        let date = UILabel()
        date.font = UIFont.preferredFont(forTextStyle: .footnote)
        date.textColor = .secondaryLabel
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellViews() {
        contentView.addSubview(tagStack)
        contentView.addSubview(title)
        contentView.addSubview(body)
        contentView.addSubview(lastModifiedDate)
    }
    
    private func setupCell() {
        setupCellViews()
        let horizontalInset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            tagStack.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 0.5),
            tagStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            tagStack.heightAnchor.constraint(equalToConstant: 20),
            
            title.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: tagStack.lastBaselineAnchor, multiplier: 1),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            body.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: title.lastBaselineAnchor, multiplier: 1.2),
            body.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset),
            
            lastModifiedDate.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: body.lastBaselineAnchor, multiplier: 1.1),
            lastModifiedDate.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            lastModifiedDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset),
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: lastModifiedDate.lastBaselineAnchor, multiplier: 0.5)
        ])
    }
}
