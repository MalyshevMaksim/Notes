//
//  File.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "rectangle.stack.fill"), selectedImage: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
