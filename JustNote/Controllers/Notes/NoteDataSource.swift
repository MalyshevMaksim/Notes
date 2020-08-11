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
    var applicationData: CoreDataController!
    
    init(with applicationData: CoreDataController) {
        self.applicationData = applicationData
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return applicationData.controller.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applicationData.controller.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell else {
            fatalError("Error: Unable to dequeue")
        }
        cell.configure(with: applicationData.controller.object(at: indexPath))
        return cell
    }
}
