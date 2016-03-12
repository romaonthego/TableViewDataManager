//
// RootViewController.swift
// TableViewManager
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
import TableViewManager

class RootViewController: UITableViewController {

    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = TableViewManager(tableView: self.tableView)
    
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
            section.items = [
                TableViewItem(text: "Forms", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Forms", sender: nil)
                }),
                TableViewItem(text: "Interface Builder Support", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Interface Builder Support", sender: nil)
                }),
                TableViewItem(text: "Editing", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Editing", sender: nil)
                }),
                TableViewItem(text: "Retractable", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Retractable", sender: nil)
                }),
                TableViewItem(text: "Styling", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Style", sender: nil)
                }),
                TableViewItem(text: "Indexed List", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Indexed List", sender: nil)
                })
            ]
            
            return section
        }())
    }
}
