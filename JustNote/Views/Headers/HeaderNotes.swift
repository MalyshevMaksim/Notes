//
//  HeaderNotes.swift
//  JustNote
//
//  Created by Максим on 21.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class HeaderNotes: UIView {
    
    lazy var text: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(title: String, icon: String, frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        text.text = title
        imageView.image = UIImage(systemName: icon)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.addSubview(text)
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            text.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 30),
            text.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            text.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            text.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
