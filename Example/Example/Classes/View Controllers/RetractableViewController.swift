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
    
    // MARK: View life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var simpleConfigurationHandler: ((tableViewCell: TableViewCell) -> (Void)) = { (tableViewCell: TableViewCell) in
            tableViewCell.accessoryType = .None
        }
        var accessoryConfigurationHandler: ((tableViewCell: TableViewCell) -> (Void)) = { (tableViewCell: TableViewCell) in
            tableViewCell.accessoryType = .DisclosureIndicator
        }
        var collapsedItems: [TableViewItem] = []
        var expandedItems: [TableViewItem] = []
        
        collapsedItems = [
            TableViewItem(text: "Test Item 1", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Test Item 2", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Test Item 3", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Test Item 4", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Show More", configurationHandler: accessoryConfigurationHandler, selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                section.items = expandedItems
                tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            })
        ]
        
        expandedItems = [
            TableViewItem(text: "Test Item 1", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Test Item 2", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Test Item 3", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Test Item 4", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Test Item 5", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Test Item 6", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Test Item 7", configurationHandler: simpleConfigurationHandler),
            TableViewItem(text: "Show More", configurationHandler: accessoryConfigurationHandler, selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                section.items = collapsedItems
                tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            })
        ]
        
        // Add a section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection()
            section.items = collapsedItems
            return section
        }())
    }

}
