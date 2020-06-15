//
//  ConfiguringCell.swift
//  JustNote
//
//  Created by Максим on 15.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

protocol ConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with app: NoteBoard)
}
