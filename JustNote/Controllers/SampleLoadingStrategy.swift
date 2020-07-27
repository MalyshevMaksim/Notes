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
    func isFirstAppear(forKey key: String) -> Bool {
        if !UserDefaults.standard.bool(forKey: key) {
            UserDefaults.standard.set(true, forKey: key)
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
        guard let coreDataStack = coreDataStack, isFirstAppear(forKey: "Boards") == false else {
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
        guard let coreDataStack = coreDataStack, isFirstAppear(forKey: "Notes") == false else {
            return
        }
        
        for note in data {
            let noteDictionary = note as! [String : Any]
            let note = Note(context: coreDataStack.managedContext)
            note.title = noteDictionary["title"] as? String
            note.body = noteDictionary["body"] as? String
            note.date = noteDictionary["date"] as? Date
            
            
            let favoriteTag = Tag(context: coreDataStack.managedContext)
            favoriteTag.color = .systemOrange
            favoriteTag.text = "Favorite"
            
            let pinnedTag = Tag(context: coreDataStack.managedContext)
            pinnedTag.color = .systemBlue
            pinnedTag.text = "Pinned"
            
            note.addToTags(pinnedTag)
            note.addToTags(favoriteTag)
        }
        coreDataStack.saveContext()
    }
}
