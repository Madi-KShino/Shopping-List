//
//  List+Convenience.swift
//  ShoppingList
//
//  Created by Madison Kaori Shino on 6/21/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import CoreData

extension ShoppingList {
    @discardableResult
    convenience init(item: String, wasBought: Bool, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.item = item
        self.wasBought = false
    }
}
