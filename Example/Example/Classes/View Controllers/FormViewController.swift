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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manager.dataSource?.sections = [{
            let section = TableViewSection()
            section.items = [
                {
                    let textItem = TableViewTextItem()
                    return textItem
                }(),
                {
                    let textItem = TableViewTextItem()
                    return textItem
                }()]
            return section
        }()]
    }
}
