//
//  ViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = {
        let manager = TableViewManager(tableView: self.tableView)
        manager.registerNib(UINib(nibName: "IBTableViewCell", bundle: NSBundle.mainBundle()), forItemClass: IBTableViewItem.self)
        return manager
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
            section.items = [{
                let item = TableViewItem(text: "First item")
                return item
            }(), {
                let item = IBTableViewItem(text: "Second item")
                item.height = 100
                return item
            }()]
            
            return section
        }())
    }
}

