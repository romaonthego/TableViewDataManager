//
//  IndexedListViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/4/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class IndexedListViewController: UITableViewController {

    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = TableViewManager(tableView: self.tableView)
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for indexTitle in ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] {
            self.manager.dataSource!.sections.append({
                let section = TableViewSection(headerTitle: indexTitle)
                section.indexTitle = indexTitle
                
                // Add 5 items with name `section title + item index`
                //
                for (var i = 1; i <= 5; i++) {
                    section.items.append(TableViewItem(text: "\(indexTitle)-\(i)"))
                }
                return section
            }())
        }
    }

}
