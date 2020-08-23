//
//  NotesDataSource.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/8/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NoteDataSource: NSObject, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CoreDataStack.shared.fetchRequestController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataStack.shared.fetchRequestController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell else {
            fatalError("Error: Unable to dequeue")
        }
        
        cell = NoteCell()
        cell.configure(with: CoreDataStack.shared.fetchRequestController.object(at: indexPath))
        return cell
    }
}
