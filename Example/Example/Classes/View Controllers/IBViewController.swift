//
//  IBViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/4/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class IBViewController: UITableViewController {

    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = {
        let manager = TableViewManager(tableView: self.tableView)
        
        // Register a Nib for an item class
        //
        manager.registerNib(UINib(nibName: "IBTableViewCell", bundle: NSBundle.mainBundle()), forItemClass: IBTableViewItem.self)
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manager.dataSource!.sections.append({
            let section = TableViewSection()
            for (var i = 1; i <= 10; i++) {
                var lines : [String] = []
                for index in 1...i {
                    lines.append("Line \(index)")
                }
                let item = IBTableViewItem(text: "\n".join(lines))
                item.selectable = false
                item.height = Float(UITableViewAutomaticDimension)
                section.items.append(item)
            }
            return section
        }())
    }
}
