//
//  Tag+CoreDataClass.swift
//  
//
//  Created by Малышев Максим Алексеевич on 7/26/20.
//
//

import Foundation
import CoreData
import UIKit

enum TagEnum: String {
    case pinned
    case favorited
    case protected
    
    var text: String {
        switch self {
            case .pinned: return "Pinned"
            case .favorited: return "Favorite"
            case .protected: return "Protected"
        }
    }
    
    var color: UIColor {
        switch self {
            case .pinned: return .systemBlue
            case .favorited: return .systemOrange
            case .protected: return .systemGreen
        }
    }
}

@objc(Tag)
public class Tag: NSManagedObject {
    var type: TagEnum = .favorited {
        didSet {
            text = type.text
            color = type.color
        }
    }
}
