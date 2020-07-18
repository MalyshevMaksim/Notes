//
//  LoadingStrategy.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 18.07.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol LoadingStrategy {
    var managedContext: NSManagedObjectContext! { get }
    func load(data: NSArray)
}

class LoaderSampleBoard: LoadingStrategy {
    var managedContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedContext = context
    }
    
    func load(data: NSArray) {
        for board in data {
            let boardDictionary = board as! [String : Any]
            let board = Board(context: managedContext)
            board.title = boardDictionary["title"] as? String
            board.numberOfNotes = boardDictionary["numberOfNotes"] as! Int16
            board.iconName = boardDictionary["iconName"] as? String
            board.tintColor = UIColor.color(dict: boardDictionary["tintColor"] as! [String : Any])!
        }
        try! managedContext.save()
    }
}

class LoaderSampleNote: LoadingStrategy {
    var managedContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedContext = context
    }
    
    func load(data: NSArray) {
        
    }
}

private extension UIColor {
    static func color(dict: [String : Any]) -> UIColor? {
        guard let red = dict["red"] as? NSNumber,
              let green = dict["green"] as? NSNumber,
              let blue = dict["blue"] as? NSNumber else {
            return nil
        }
        return UIColor(red: CGFloat(truncating: red) / 255.0, green: CGFloat(truncating: green) / 255.0, blue: CGFloat(truncating: blue) / 255.0, alpha: 1)
    }
}
