//
//  Image+CoreDataProperties.swift
//  
//
//  Created by Малышев Максим Алексеевич on 8/26/20.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var note: Note?

}
