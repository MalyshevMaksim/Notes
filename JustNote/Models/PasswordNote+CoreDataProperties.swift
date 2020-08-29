//
//  PasswordNote+CoreDataProperties.swift
//  
//
//  Created by Малышев Максим Алексеевич on 8/29/20.
//
//

import Foundation
import CoreData
import UIKit

extension PasswordNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PasswordNote> {
        return NSFetchRequest<PasswordNote>(entityName: "PasswordNote")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: UIImage?

}
