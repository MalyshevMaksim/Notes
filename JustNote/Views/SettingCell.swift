//
//  SettingCell.swift
//  JustNote
//
//  Created by Максим on 18.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    static var reuseIdentifier = "SettingCell"
    
    func configure(with model: SettingRow) {
        textLabel?.text = model.text
        imageView?.image = UIImage(systemName: model.iconName!)
        accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1647058824, blue: 0.1843137255, alpha: 1)
    }
}
