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
    func load(data: NSArray, to dataStack: CoreDataStack)
}

extension SampleLoadingStrategy {
    // Sample data should only be loaded at the first show
    func isFirstAppear(forKey key: String) -> Bool {
        if !UserDefaults.standard.bool(forKey: key) {
            UserDefaults.standard.set(true, forKey: key)
            return false
        }
        return true
    }
}

class SampleBoardLoader: SampleLoadingStrategy {
    func load(data: NSArray, to dataStack: CoreDataStack) {
        guard isFirstAppear(forKey: "Boards") == false else {
            return
        }
        for board in data {
            let boardDictionary = board as! [String : Any]
            let board = Board(context: dataStack.managedContext)
            board.title = boardDictionary["title"] as? String
            board.iconName = boardDictionary["iconName"] as? String
            board.tintColor = UIColor.color(dict: boardDictionary["tintColor"] as! [String : Any])!
            board.section = boardDictionary["section"] as? String
        }
        dataStack.saveContext()
    }
}

class SampleNoteLoader: SampleLoadingStrategy {
    func load(data: NSArray, to dataStack: CoreDataStack) {
        guard isFirstAppear(forKey: "Notes") == false else {
            return
        }
        
        let request: NSFetchRequest<Board> = Board.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(Board.title), "Typed"])
        let result = try! dataStack.managedContext.fetch(request)
        
        for note in data {
            let noteDictionary = note as! [String : Any]
            let note = Note(context: dataStack.managedContext)
            note.title = noteDictionary["title"] as? String
            note.body = noteDictionary["body"] as? String
            note.date = noteDictionary["date"] as? Date
            note.isLocked = noteDictionary["isLocked"] as! Bool
            note.isPinned = noteDictionary["isPinned"] as! Bool
            note.isFavorite = noteDictionary["isFavorite"] as! Bool
            note.section = "Others"
            
            if note.isLocked == true {
                note.attachTag(color: .systemGreen, text: "Protected")
            }
            if note.isPinned == true {
                note.attachTag(color: .systemBlue, text: "Pinned")
                note.section = "Pinned"
            }
            if note.isFavorite == true {
                note.attachTag(color: .systemOrange, text: "Favorite")
            }
            result.first?.addToNotes(note)
        }
        dataStack.saveContext()
    }
}
