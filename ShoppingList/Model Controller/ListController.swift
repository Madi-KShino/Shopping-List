//
//  ListController.swift
//  ShoppingList
//
//  Created by Madison Kaori Shino on 6/21/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import CoreData

class ListController {
    
    //MARK: - SINGLETON & SOURCE OF TRUTH
    static let sharedInstance = ListController()
    
//    var fetchedResultsController
    
    init() {
        
    }
    
    //MARK: - EDITING FUNCTIONS
    func addItem(item: String) {
        ShoppingList(item: item, wasBought: false)
        saveToPersistentStore()
    }
    
    func removeItem(item: ShoppingList) {
        CoreDataStack.managedObjectContext.delete(item)
        saveToPersistentStore()
    }
    
    func editItem(listItem: ShoppingList, item: String) {
        listItem.item = item
        saveToPersistentStore()
    }
    
    func toggleWasBoughtFor(item: ShoppingList) {
        item.wasBought = !item.wasBought
        saveToPersistentStore()
    }

    //MARK: - PERSISTENCE
    func saveToPersistentStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch {
            print("Error Saving to Persistent Store", error.localizedDescription)
        }
    }
}
