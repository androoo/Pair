//
//  PersonController .swift
//  Pair
//
//  Created by Andrew Ervin Gierke on 3/10/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    //MARK: - Properties
    
    static let shared = PersonController()
    
    var people: [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    var persons: [Person] = []
    var pairs: [[Person]] {
        return makePairs(peopleArray: persons)
    }
    
    
    //MARK: - Life Cycle
    
    init() {
        loadFromPersistentStore()
    }
    
    
    //MARK: - CRUD
    
    func addPersonNamed(name: String) {
        let _ = Person(name: name)
        saveToPersistentStore()
    }
    
    func makePairs(peopleArray: [Person]) -> [[Person]] {
        let splitSize = 2
        let sectionsOfPeople = stride(from: 0, to: peopleArray.count, by: splitSize).map {
            
            Array(peopleArray[$0..<min($0 + splitSize, peopleArray.count)])
            
        }
        return sectionsOfPeople
    }
    
    func randomize() {
        persons.random()
        saveToPersistentStore()
    }
    
    
    //MARK: - Persistence
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("\(error)")
        }
    }
    
    func loadFromPersistentStore() {
        persons = people
    }
}


extension Array {
    mutating func random() {
        for _ in 0..<10 { sort { (_,_) in arc4random() < arc4random() }}
    }
}
