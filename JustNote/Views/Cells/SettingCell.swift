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
    }
}
