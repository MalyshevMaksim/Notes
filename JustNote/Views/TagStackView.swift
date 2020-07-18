//
//  TagStackView.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 01.07.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class TagStack: UIStackView {
    var tags: [TagView]
    
    init(tags: [TagView]) {
        self.tags = tags
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        configureStack()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStack() {
        tags.forEach { tag in
            addArrangedSubview(tag)
        }
        spacing = 6
        axis = .horizontal
        translatesAutoresizingMaskIntoConstraints = false
    }
}
