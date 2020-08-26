//
//  SampleDataLoader.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 18.07.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import CoreData

enum SampleLoaderStrategyEnum {
    case noteLoader
    case boardLoader
    
    var loader: SampleLoadingStrategy {
        switch self {
            case .noteLoader: return SampleNoteLoader()
            case .boardLoader: return SampleBoardLoader()
        }
    }
    
    var path: String {
        switch self {
            case .noteLoader: return "SampleNotes"
            case .boardLoader: return "SampleBoards"
        }
    }
}

class SampleDataLoader {
    private var loader: SampleLoadingStrategy!
    private var path: String!
    
    var loaderStrategy: SampleLoaderStrategyEnum! {
        didSet {
            loader = loaderStrategy.loader
            path = loaderStrategy.path
        }
    }

    func load() {
        guard let filePath = Bundle.main.path(forResource: path, ofType: "plist"),
              let loadedData = NSArray(contentsOfFile: filePath) else {
            fatalError("Failed to load data: file not found!")
        }
        // Сonvert the data received from the plist into specific types in accordance with the chosen strategy
        loader.convertData(loadedData)
    }
}
