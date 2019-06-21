//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Madison Kaori Shino on 6/21/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    //DELEGATE PROPERTY
    weak var cellDelegate: ButtonTableViewCellDelegate?
    
    //MARK: - OUTLETS
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    //MARK: - ACTIONS
    @IBAction func checkButtonTapped(_ sender: Any) {
        cellDelegate?.cellButtonTapped(self)
//        ListController.sharedInstance.toggleWasBoughtFor(item: <#T##ShoppingList#>)
    }
    
    //MARK: FUNCTIONS
    func updateButton(_ wasBought: Bool) {
        switch wasBought {
        case true:
            checkButton.setImage(UIImage(named: "checked"), for: .normal)
        case false:
            checkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
}

//MARK: - EXTENSIONS
extension ItemTableViewCell {
    func update(item: ShoppingList) {
        itemNameLabel.text = item.item
        updateButton(item.wasBought)
    }
}

//MARK: - PROTOCOLS
protocol AddItemAlertDelegate {
    func addNewItemAlert()
}

protocol ButtonTableViewCellDelegate: class {
    func cellButtonTapped(_ sender: ItemTableViewCell)
}
