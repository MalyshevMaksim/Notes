//
//  Note.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

let bordersOfNotes: [NoteBorder] = [
    NoteBorder(icon: "pencil", title: "Typed", subtitle: "12 notes", isLocked: false, iconColor: .systemIndigo),
    NoteBorder(icon: "mic.fill", title: "Audio", subtitle: "10 notes", isLocked: false, iconColor: .systemPink),
    NoteBorder(icon: "person.fill", title: "Contacts", subtitle: "20 notes", isLocked: false, iconColor: .systemBlue),
    NoteBorder(icon: "lock.fill", title: "Passwords", subtitle: "3 notes", isLocked: true, iconColor: .systemGreen)
]

struct NoteBorder {
    var icon: String
    var title: String
    var subtitle: String
    var isLocked: Bool
    var iconColor: UIColor
}
