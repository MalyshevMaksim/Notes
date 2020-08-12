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
    private var loader: SampleLoadingStrategy
    
    init(with loader: SampleLoadingStrategy) {
        self.loader = loader
    }
    
    func setLoader(loader: SampleLoadingStrategy) {
        self.loader = loader
    }
    
    func load(path: String, type: String) {
        guard let filePath = Bundle.main.path(forResource: path, ofType: type),
              let loadedData = NSArray(contentsOfFile: filePath) else {
            fatalError("Failed to load data: file not found!")
        }
        loader.load(data: loadedData)
    }
}
