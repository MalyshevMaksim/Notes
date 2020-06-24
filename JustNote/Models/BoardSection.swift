//
//  Section.swift
//  JustNote
//
//  Created by Максим on 15.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation

var sections = [BoardSection(id: 0, title: "Folders", subtitle: "", type: "defaultBoardings", items: bordersOfNotes)]

struct BoardSection: Hashable  {
    var hashValue: Int {
        return id.hashValue
    }
    
    var id: Int
    var title: String
    var subtitle: String
    var type: String
    var items: [NoteBoard]
}
