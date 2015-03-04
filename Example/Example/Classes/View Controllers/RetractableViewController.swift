//
//  RetractableViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/4/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class RetractableViewController: UITableViewController {

    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = TableViewManager(tableView: self.tableView)
    
    // Static configuration handlers
    //
    static var simpleConfigurationHandler: ((tableViewCell: TableViewCell) -> (Void)) = { (tableViewCell: TableViewCell) in
        tableViewCell.accessoryType = .None
    }
    static var accessoryConfigurationHandler: ((tableViewCell: TableViewCell) -> (Void)) = { (tableViewCell: TableViewCell) in
        tableViewCell.accessoryType = .DisclosureIndicator
    }
    
    // Static arrays of collapsed and expanded items
    //
    static var collapsedItems: [TableViewItem] = [
        TableViewItem(text: "Test Item 1", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Test Item 2", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Test Item 3", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Test Item 4", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Show More", configurationHandler: accessoryConfigurationHandler, selectionHandler: { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
            section.items = expandedItems
            tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        })
    ]
    static var expandedItems: [TableViewItem] = [
        TableViewItem(text: "Test Item 1", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Test Item 2", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Test Item 3", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Test Item 4", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Test Item 5", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Test Item 6", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Test Item 7", configurationHandler: simpleConfigurationHandler),
        TableViewItem(text: "Show More", configurationHandler: accessoryConfigurationHandler, selectionHandler: { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
            section.items = collapsedItems
            tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        })
    ]
    
    // MARK: View life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection()
            section.items = self.dynamicType.collapsedItems
            return section
        }())
    }

}
