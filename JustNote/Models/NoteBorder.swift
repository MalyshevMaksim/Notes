//
//  Note.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation

let bordersOfNotes: [NoteBorder] = [
    NoteBorder(icon: "pencil", title: "Typed", subtitle: "12 notes"),
    NoteBorder(icon: "mic.fill", title: "Audio", subtitle: "10 notes"),
    NoteBorder(icon: "person.fill", title: "Contacts", subtitle: "20 notes"),
    NoteBorder(icon: "lock.fill", title: "Passwords", subtitle: "3 notes")
]

struct NoteBorder {
    var icon: String
    var title: String
    var subtitle: String
}
