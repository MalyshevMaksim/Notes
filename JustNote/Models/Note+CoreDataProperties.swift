//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Малышев Максим Алексеевич on 8/5/20.
//
//

import Foundation
import CoreData
import UIKit

extension Note {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var isLocked: Bool
    @NSManaged public var isPinned: Bool
    @NSManaged public var title: String?
    @NSManaged public var section: String?
    @NSManaged public var board: Board?
    @NSManaged public var tags: NSSet?
    
    func configureTags() {
        if isLocked == true {
            attachTag(type: .protected)
        }
        if isPinned == true {
            attachTag(type: .pinned)
            section = "Pinned"
        }
        if isFavorite == true {
            attachTag(type: .favorited)
        }
    }
    
    func attachTag(type: TagEnum) {
        let tag = Tag(context: CoreDataStack.shared.managedContext)
        tag.type = type
        addToTags(tag)
    }
    
    func detachTag(type: TagEnum) {
        guard let tags = tags else {
            return
        }
        for tag in tags {
            let currentTag = tag as! Tag
            if currentTag.text == type.rawValue {
                removeFromTags(currentTag)
            }
        }
    }
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
