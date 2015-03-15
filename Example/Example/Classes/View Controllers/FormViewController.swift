//
//  FormViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class FormViewController: UITableViewController {

    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = TableViewManager(tableView: self.tableView)
    
    // Lazy initialize form fields
    //
    lazy var fullLengthTextField: TableViewTextItem = {
        let textItem = TableViewTextItem()
        textItem.placeholder = "Full length text field"
        return textItem
    }()
    lazy var textItem: TableViewTextItem = {
        let textItem = TableViewTextItem(text: "Text item")
        textItem.placeholder = "Placeholder text"
        return textItem
    }()
    lazy var numberItem: TableViewTextItem = {
        let numberItem = TableViewTextItem(text: "Phone")
        numberItem.placeholder = "(123) 456-7890"
        return numberItem
    }()
    lazy var passwordItem: TableViewTextItem = {
        let passwordItem = TableViewTextItem(text: "Password")
        passwordItem.secureTextEntry = true
        passwordItem.placeholder = "Password item"
        return passwordItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manager.dataSource?.sections = [{
            let section = TableViewSection()
            section.items = [self.fullLengthTextField, self.textItem, self.numberItem, self.passwordItem]
            return section
        }()]
    }
    
    // MARK: Read values
    //
    
    @IBAction func valuesButtonPressed(sender: AnyObject) {
        println("Full length text field value: \(self.fullLengthTextField.value)")
    }
}
