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
        configureTagStack(with: model)
        title.text = model.title
        body.text = model.body
        lastModifiedDate.text = "last changed: \(dateFormatter.string(from: model.date!))"
        backgroundColor = .systemBackground
    }
    
    func configureTagStack(with model: Note) {
        tagStack.removeAllArrangedSubviews()
        
        if let tags = model.tags?.allObjects {
            for tag in tags {
                let tagView = TagView()
                tagView.configure(with: tag as! Tag)
                tagStack.addArrangedSubview(tagView)
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter
    }
    
    private lazy var tagStack: UIStackView = {
        let tags = UIStackView()
        tags.spacing = 6
        tags.axis = .horizontal
        tags.translatesAutoresizingMaskIntoConstraints = false
        return tags
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
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 18
        stackView.addArrangedSubview(RoundedImage())
        stackView.addArrangedSubview(RoundedImage())
        stackView.addArrangedSubview(RoundedImage())
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        contentView.addSubview(imageStackView)
    }
    
    private func setupCell() {
        setupCellViews()
        let horizontalInset: CGFloat = 15
        
        NSLayoutConstraint.activate([
            tagStack.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 0.5),
            tagStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            tagStack.heightAnchor.constraint(equalToConstant: 20),
            
            title.topAnchor.constraint(equalTo: tagStack.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            body.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset),
            
            imageStackView.topAnchor.constraint(equalTo: body.bottomAnchor, constant: 10),
            imageStackView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            
            lastModifiedDate.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 40),
            lastModifiedDate.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            lastModifiedDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset),
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: lastModifiedDate.lastBaselineAnchor, multiplier: 0.5)
        ])
    }
}
