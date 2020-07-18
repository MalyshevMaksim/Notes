//
//  HeaderGridLayout.swift
//  JustNote
//
//  Created by Максим on 18.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class HeaderGridLayout: UICollectionReusableView {
    static var reuseIdentifier = "HeaderGridCell"
    
    func configure() {
        header.text = "Boards"
    }
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeader() {
        self.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            header.topAnchor.constraint(equalTo: self.topAnchor),
            header.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
