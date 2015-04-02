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
    lazy var fullLengthTextField = TableViewTextItem(text: nil, placeholder: "Full length text field", value: nil)
    lazy var textItem = TableViewTextItem(text: "Text item", placeholder: "Placeholder text", value: nil)
    lazy var numberItem = TableViewTextItem(text: "Phone", placeholder: "(123) 456-7890", value: nil)
    lazy var passwordItem: TableViewTextItem = {
        let item = TableViewTextItem(text: "Password", placeholder: "Password item", value: nil)
        item.secureTextEntry = true
        return item
    }()
    lazy var switchItem: TableViewSwitchItem = {
        let item = TableViewSwitchItem(text: "Switch", value: true)
        item.changeHandler = { (section: TableViewSection, item: TableViewSwitchItem, tableView: UITableView, indexPath: NSIndexPath) in
            println("Switch value: \(item.value)")
        }
        return item
    }()
    lazy var sliderItem: TableViewSliderItem = {
        let item = TableViewSliderItem(text: "Slider", value: 0.2)
        item.changeHandler = { (section: TableViewSection, item: TableViewSliderItem, tableView: UITableView, indexPath: NSIndexPath) in
            println("Slider value: \(item.value)")
        }
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manager.dataSource?.sections = [{
            let section = TableViewSection()
            section.items = [
                self.fullLengthTextField,
                self.textItem,
                self.numberItem,
                self.passwordItem,
                self.switchItem,
                self.sliderItem
            ]
            return section
        }()]
    }
    
    // MARK: Read values
    //
    
    @IBAction func valuesButtonPressed(sender: AnyObject) {
        println("Full length text field value: \(self.fullLengthTextField.value)")
    }
}
