//
//  PasswordCell.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/28/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit
import Locksmith

class PasswordCell: UITableViewCell {
    static var reuseIdentifier = "NoteCell"
    
    var title: UILabel = {
        let label = UILabel()
        label.text = "Apple"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    var body: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter
    }
    
    func configure(with model: PasswordNote) {
        title.text = model.title
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "\(model.id!)")
        body.text = "Login: \((dictionary!["Login"] as! String))"
        body2.text = "Password: \((dictionary!["Password"] as! String))"
        imageS.image = model.image
        lastModifiedDate.text = "last changed: \(dateFormatter.string(from: model.date!))"
        backgroundColor = .systemBackground
    }
    
    var body2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var imageS: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "apple"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var lastModifiedDate: UILabel = {
        let date = UILabel()
        date.text = "last changed: \(dateFormatter.string(from: Date()))"
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
    
    private func setupViews() {
        contentView.addSubview(title)
        contentView.addSubview(body)
        contentView.addSubview(lastModifiedDate)
        contentView.addSubview(body2)
        contentView.addSubview(imageS)
    }
    
    private func setupCell() {
        setupViews()
        
        NSLayoutConstraint.activate([
            imageS.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageS.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            imageS.heightAnchor.constraint(equalToConstant: 40),
            imageS.widthAnchor.constraint(equalToConstant: 40),
            
            title.leadingAnchor.constraint(equalTo: imageS.trailingAnchor, constant: 20),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            body.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            body2.topAnchor.constraint(equalTo: body.bottomAnchor, constant: 5),
            body2.leadingAnchor.constraint(equalTo: body.leadingAnchor),
            body2.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            lastModifiedDate.topAnchor.constraint(equalTo: body2.bottomAnchor, constant: 5),
            lastModifiedDate.leadingAnchor.constraint(equalTo: body2.leadingAnchor),
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: lastModifiedDate.lastBaselineAnchor, multiplier: 0.5)
        ])
    }
}
