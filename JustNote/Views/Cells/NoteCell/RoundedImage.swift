//
//  RoundedImage.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/14/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class RoundedImage: UIView {
    func configure(with model: Image) {
        imageView.image = model.image
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2.5
        imageView.layer.borderColor = .init(srgbRed: 20, green: 20, blue: 20, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 35),
            imageView.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
}
