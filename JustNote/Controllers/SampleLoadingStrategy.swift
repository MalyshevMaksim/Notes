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
    func convertData(_ data: NSArray)
}

extension SampleLoadingStrategy {
    // Sample data should only be loaded at the first show
    func isFirstAppear(for key: String) -> Bool {
        if !UserDefaults.standard.bool(forKey: key) {
            UserDefaults.standard.set(true, forKey: key)
            return false
        }
        return true
    }
}

class SampleBoardLoader: SampleLoadingStrategy {
    func convertData(_ data: NSArray) {
        guard isFirstAppear(for: "Boards") == false else {
            return
        }
        
        for board in data {
            let boardDictionary = board as! [String : Any]
            let board = Board(context: CoreDataStack.shared.managedContext)
            board.title = boardDictionary["title"] as? String
            board.iconName = boardDictionary["iconName"] as? String
            board.tintColor = UIColor.color(dict: boardDictionary["tintColor"] as! [String : Any])!
            board.section = boardDictionary["section"] as? String
        }
        CoreDataStack.shared.saveContext()
    }
}

class SampleNoteLoader: SampleLoadingStrategy {
    func convertData(_ data: NSArray) {
        guard isFirstAppear(for: "Notes") == false else {
            return
        }
        
        for note in data {
            let noteDictionary = note as! [String : Any]
            let note = TextNote(context: CoreDataStack.shared.managedContext)
            note.title = noteDictionary["title"] as? String
            note.body = noteDictionary["body"] as? String
            note.date = noteDictionary["date"] as? Date
            note.isLocked = noteDictionary["isLocked"] as! Bool
            note.isPinned = noteDictionary["isPinned"] as! Bool
            note.isFavorite = noteDictionary["isFavorite"] as! Bool
            note.section = "Others"
    
            note.configureTags()
            addNoteToContext(note)
        }
        CoreDataStack.shared.saveContext()
    }
    
    private func addNoteToContext(_ note: Note) {
        let request: NSFetchRequest<Board> = Board.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(Board.title), "Typed"])
        let result = try! CoreDataStack.shared.managedContext.fetch(request)
        result.first?.addToNotes(note)
    }
}
