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

protocol SampleLoadingStrategy {
    func load(data: NSArray)
}

extension SampleLoadingStrategy {
    // Sample data loading should be done only at the first launch of the application
    func isFirstApplicationLaunch() -> Bool {
        if !UserDefaults.standard.bool(forKey: "isApplicationLaunched") {
            UserDefaults.standard.set(true, forKey: "isApplicationLaunched")
            return false
        }
        return true
    }
}

class LoadingSampleBoard: SampleLoadingStrategy {
    var coreDataStack: CoreDataStack?
    
    init(stack: CoreDataStack) {
        coreDataStack = stack
    }
    
    func load(data: NSArray) {
        guard let coreDataStack = coreDataStack, isFirstApplicationLaunch() == false else {
            return
        }
        
        for board in data {
            let boardDictionary = board as! [String : Any]
            let board = Board(context: coreDataStack.managedContext)
            board.title = boardDictionary["title"] as? String
            board.numberOfNotes = boardDictionary["numberOfNotes"] as! Int16
            board.iconName = boardDictionary["iconName"] as? String
            board.tintColor = UIColor.color(dict: boardDictionary["tintColor"] as! [String : Any])!
        }
        coreDataStack.saveContext()
    }
}

class LoadingSampleNote: SampleLoadingStrategy {
    var coreDataStack: CoreDataStack?
    
    init(stack: CoreDataStack) {
        coreDataStack = stack
    }
    
    func load(data: NSArray) {
        guard let coreDataStack = coreDataStack, isFirstApplicationLaunch() == false else {
            return
        }
        
        for note in data {
            
        }
        coreDataStack.saveContext()
    }
}

class LoadingSampleSettings: SampleLoadingStrategy {
    func load(data: NSArray) {
        guard isFirstApplicationLaunch() == false else {
            return
        }
        
        for row in data {
            
        }
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
