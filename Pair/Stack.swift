//
//  Stack.swift
//  Pair
//
//  Created by Andrew Ervin Gierke on 3/10/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import Foundation

import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Pair")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}
