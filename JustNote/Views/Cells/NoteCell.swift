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
    
    let tagStack = UIStackView()
    let noteTitle = UILabel()
    let noteBody = UILabel()
    let lastModifedDate = UILabel()
    
    func configure(with model: Note) {
        configureTagStack()
        configureNoteTitle()
        configureNoteBody()
        configureLastModifedDate()
        
        noteBody.text = model.text
        noteTitle.text = model.title
        lastModifedDate.text = model.date
        
        tagStack.removeAllArrangedSubviews()
        for item in 0..<model.tags.count {
            let tag = TagView(type: model.tags[item], frame: CGRect())
            tagStack.addArrangedSubview(tag)
        }
    }
    
    private func configureTagStack() {
        tagStack.spacing = 6
        tagStack.axis = .horizontal
        tagStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNoteTitle() {
        noteTitle.font = UIFont.boldSystemFont(ofSize: 20)
        noteTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNoteBody() {
        noteBody.font = UIFont.preferredFont(forTextStyle: .callout)
        noteBody.translatesAutoresizingMaskIntoConstraints = false
        noteBody.lineBreakMode = .byTruncatingTail
        noteBody.numberOfLines = 2
    }
    
    private func configureLastModifedDate() {
        lastModifedDate.font = UIFont.preferredFont(forTextStyle: .footnote)
        lastModifedDate.textColor = .secondaryLabel
        lastModifedDate.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellViews() {
        contentView.addSubview(tagStack)
        contentView.addSubview(noteTitle)
        contentView.addSubview(noteBody)
        contentView.addSubview(lastModifedDate)
    }
    
    private func setupCell() {
        setupCellViews()
        let horizontalInset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            tagStack.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 0.5),
            tagStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            tagStack.heightAnchor.constraint(equalToConstant: horizontalInset),
            
            noteTitle.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: tagStack.lastBaselineAnchor, multiplier: 1),
            noteTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            noteTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            noteBody.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: noteTitle.lastBaselineAnchor, multiplier: 1.2),
            noteBody.leadingAnchor.constraint(equalTo: noteTitle.leadingAnchor),
            noteBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset),
            
            lastModifedDate.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: noteBody.lastBaselineAnchor, multiplier: 1.1),
            lastModifedDate.leadingAnchor.constraint(equalTo: noteTitle.leadingAnchor),
            lastModifedDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset),
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: lastModifedDate.lastBaselineAnchor, multiplier: 0.5)
        ])
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeView(view: view)
        }
    }
    
    private func removeView(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
}
