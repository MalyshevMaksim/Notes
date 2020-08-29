//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Малышев Максим Алексеевич on 8/28/20.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isPinned: Bool
    @NSManaged public var section: String?
    @NSManaged public var title: String?
    @NSManaged public var board: Board?
}
