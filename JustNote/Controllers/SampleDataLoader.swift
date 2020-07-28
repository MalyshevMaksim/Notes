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
    private var loader: SampleLoadingStrategy!
    private var path: String
    private var type: String
    
    init(path: String, type: String) {
        self.path = path
        self.type = type
    }
    
    func load(with loader: SampleLoadingStrategy, to dataStack: CoreDataStack) {
        guard let filePath = Bundle.main.path(forResource: path, ofType: type),
              let loadedData = NSArray(contentsOfFile: filePath) else {
            fatalError("Failed to load data: file not found!")
        }
        self.loader = loader
        self.loader.load(data: loadedData, to: dataStack)
    }
}
