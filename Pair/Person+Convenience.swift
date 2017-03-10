//
//  Person+Convenience.swift
//  Pair
//
//  Created by Andrew Ervin Gierke on 3/10/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    @discardableResult convenience init?(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
