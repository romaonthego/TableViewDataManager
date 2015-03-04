//
//  RootViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/4/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = {
        let manager = TableViewManager(tableView: self.tableView)
        return manager
    }()
    
    // MARK: View life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection()
            
            // Add items
            //
            section.items = [TableViewItem(text: "Style", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                self.performSegueWithIdentifier("Root → Show Style", sender: nil)
            })]
            
            return section
        }())
    }
}
