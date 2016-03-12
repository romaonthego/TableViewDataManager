//
// RetractableViewController.swift
// TableViewDataManager
//
// Copyright (c) 2016 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit
import TableViewDataManager

class RetractableViewController: UITableViewController {

    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewDataManager = TableViewDataManager(tableView: self.tableView)
    
    // Static configuration handlers
    //
    static var simpleConfigurationHandler: (tableViewCell: TableViewCell) -> (Void) = { (tableViewCell: TableViewCell) in
        tableViewCell.accessoryType = .None
    }
    static var accessoryConfigurationHandler: (tableViewCell: TableViewCell) -> (Void) = { (tableViewCell: TableViewCell) in
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
