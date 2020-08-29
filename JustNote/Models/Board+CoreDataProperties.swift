//
//  Board+CoreDataProperties.swift
//  
//
//  Created by Малышев Максим Алексеевич on 8/28/20.
//
//

import Foundation
import CoreData
import UIKit


extension Board {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Board> {
        return NSFetchRequest<Board>(entityName: "Board")
    }

    @NSManaged public var iconName: String?
    @NSManaged public var isLocked: Bool
    @NSManaged public var section: String?
    @NSManaged public var tintColor: UIColor?
    @NSManaged public var title: String?
    @NSManaged public var notes: NSSet?

}

// MARK: Generated accessors for notes
extension Board {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}
