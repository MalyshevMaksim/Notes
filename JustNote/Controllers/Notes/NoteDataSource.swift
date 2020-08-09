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
    var fetchedResult = FetchedResultsController()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResult.fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResult.fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell else {
            fatalError("Error: Unable to dequeue")
        }
        cell.configure(with: fetchedResult.fetchResultController.object(at: indexPath))
        return cell
    }
}
