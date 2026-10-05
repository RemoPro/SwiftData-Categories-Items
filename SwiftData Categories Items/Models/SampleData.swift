//
//  SampleData.swift
//  SwiftData Categories Items
//
//  Created by Remo Prozzillo on 05.10.2026.
//

// Sample data to use in the previews here in Xcode

import Foundation
import SwiftData

@MainActor
class SampleData {
    // create a shared instance
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    // to make the code more concise
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    // create sample data for the views that require only a single category/item
    var category: Category {
        Category.sampleData.first!
    }
    var item: Item {
        Item.sampleData.first!
    }
    
    private init() {
        // passing an array
        let schema = Schema([
            Category.self,
            Item.self
            ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        // set up ModelContainer and handle error
        do {
        modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            // insert the sample data
            insertSampleData()
            
            // try to save
            try context.save()
        } catch {
            // deal with the error that might come
            fatalError("Could not create the ModelContainer: \(error)")
            /// terminate the app
        }
    }
    
    private func insertSampleData() {
        // Loop through the sample data stored in the model class
        for category in Category.sampleData {
            context.insert(category)
        }
        
        for item in Item.sampleData {
            context.insert(item)
        }
        
        // Add the releationships
        Item.sampleData[0].category = Category.sampleData[0]
        Item.sampleData[1].category = Category.sampleData[1]
    }
    
}
