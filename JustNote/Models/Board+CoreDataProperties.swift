//
//  Board+CoreDataProperties.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 17.07.2020.
//  Copyright © 2020 Максим. All rights reserved.
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
    @NSManaged public var title: String?
    @NSManaged public var numberOfNotes: Int16
    @NSManaged public var isLocked: Bool
    @NSManaged public var tintColor: UIColor
}
