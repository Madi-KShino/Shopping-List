//
//  ListTableViewController.swift
//  ShoppingList
//
//  Created by Madison Kaori Shino on 6/21/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        ListController.sharedInstance.fetchedResultsController.delegate = self
    }

    // MARK: - TABLE VIEW DATA
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListController.sharedInstance.fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        guard let itemDisplayed = ListController.sharedInstance.fetchedResultsController.fetchedObjects?[indexPath.row]
            else { return UITableViewCell() }
        cell.textLabel?.text = itemDisplayed.item
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let itemRemoved = ListController.sharedInstance.fetchedResultsController.fetchedObjects?[indexPath.row]
                else { return }
            ListController.sharedInstance.removeItem(item: itemRemoved)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
