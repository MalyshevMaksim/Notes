//
//  Tag+CoreDataProperties.swift
//  
//
//  Created by Малышев Максим Алексеевич on 8/28/20.
//
//

import Foundation
import CoreData
import UIKit


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var text: String?
    @NSManaged public var notes: TextNote?
}
