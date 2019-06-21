//
//  ListController.swift
//  ShoppingList
//
//  Created by Madison Kaori Shino on 6/21/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ListController {
    
    //MARK: - SINGLETON & SOURCE OF TRUTH
    static let sharedInstance = ListController()
    var item: [ShoppingList] = []
    
    //MARK: - EDITING FUNCTIONS
    func addItem(item: String) {
        ShoppingList(item: item, wasBought: false)
        saveToPersistentStore()
        loadView()
    }
    
    func removeItem(item: ShoppingList) {
        CoreDataStack.managedObjectContext.delete(item)
        saveToPersistentStore()
        loadView()
    }
    
    func editItem(listItem: ShoppingList, item: String) {
        listItem.item = item
        saveToPersistentStore()
        loadView()
    }
    
    func toggleWasBoughtFor(item: ShoppingList) {
        item.wasBought = !item.wasBought
        saveToPersistentStore()
        loadView()
    }

    //MARK: - PERSISTENCE
    func saveToPersistentStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch {
            print("Error Saving to Persistent Store", error.localizedDescription)
        }
    }
    
    func loadView() {
        let request: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        do {
            let fetchedItem: [ShoppingList] =
                try CoreDataStack.managedObjectContext.fetch(request)
            ListController.sharedInstance.item = fetchedItem
        } catch {
            print(error.localizedDescription)
        }
        saveToPersistentStore()
    }
    
    
    var fetchedResultsController: NSFetchedResultsController<ShoppingList>
    
    init() {
        let request: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "wasBought", ascending: false)]
        let resultsController: NSFetchedResultsController<ShoppingList> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing the fetch request")
        }
    }
}


