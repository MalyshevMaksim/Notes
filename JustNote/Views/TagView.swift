//
//  TagView.swift
//  JustNote
//
//  Created by Максим on 21.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

enum type {
    case protected, favorite
}

class TagView: UIView {
    var tagType: type!
    
    lazy var text: UILabel = {
        let label = UILabel()
        label.text = "Favorite"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(type: type, frame: CGRect) {
        super.init(frame: frame)
        tagType = type
        
        if tagType == .favorite {
            backgroundColor = .systemOrange
            text.text = "Favorite"
            self.widthAnchor.constraint(equalToConstant: 62).isActive = true
        }
        else {
            backgroundColor = .systemGreen
            text.text = "Protected"
            self.widthAnchor.constraint(equalToConstant: 74).isActive = true
        }
        
        layer.cornerRadius = 3
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            text.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            text.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            text.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
