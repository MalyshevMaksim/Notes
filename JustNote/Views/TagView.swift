//
//  TagView.swift
//  JustNote
//
//  Created by Максим on 21.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

enum TagType: String {
    case favorite = "Favorite"
    case protected = "Protected"
}

class TagView: UIView {
    var tagType: TagType!
    
    var text: UILabel = {
        let label = UILabel()
        label.text = "123"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            text.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
            text.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            text.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.layoutMarginsGuide.trailingAnchor.constraint(equalTo: text.trailingAnchor),
            self.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
