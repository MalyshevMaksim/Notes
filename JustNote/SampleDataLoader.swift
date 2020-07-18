//
//  SampleDataLoader.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 18.07.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import CoreData

class SampleDataLoader {
    private var loadingStrategy: SampleLoadingStrategy!
    private var managedContext: NSManagedObjectContext?
    
    init(strategy: SampleLoadingStrategy) {
        loadingStrategy = strategy
    }
    
    func notApplicationLaunched() -> Bool {
        if !UserDefaults.standard.bool(forKey: "isApplicationLaunched") {
            UserDefaults.standard.set(true, forKey: "isApplicationLaunched")
            return true
        }
        return false
    }
    
    func loadData(path: String, type: String) {
        guard let dataFilePath = Bundle.main.path(forResource: path, ofType: type),
              let data = NSArray(contentsOfFile: dataFilePath) else {
            fatalError("Failed to load data")
        }
        return loadingStrategy.load(data: data)
    }
}
