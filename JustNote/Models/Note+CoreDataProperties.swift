//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Малышев Максим Алексеевич on 7/26/20.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var isLocked: Bool
    @NSManaged public var isFavorite: Bool
    @NSManaged public var isPinned: Bool
    @NSManaged public var tags: NSSet?
    @NSManaged public var board: Board?

}

// MARK: Generated accessors for tags
extension Note {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}
