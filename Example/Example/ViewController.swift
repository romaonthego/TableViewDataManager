//
//  ViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = {
        return TableViewManager(tableView: self.tableView)
    }()
    
    // MARK: View life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection(headerTitle: "Section title")
            
            // Add items
            //
            section.items = [TableViewItem(text: "First item"), {
                let item = TableViewItem(text: "Second item")
                return item
            }()]
            
            return section
        }())
    }
}

