//
// EditingViewController.swift
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

class EditingViewController: UITableViewController {

    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = TableViewManager(tableView: self.tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add "Deletable" section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection(headerTitle: "Deletable")
            
            for i in 1...5 {
                let item = TableViewItem(text: "Section 1, Item \(i)")
                item.editingStyle = .Delete
                item.deletionHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    print("Item removed: \(item.text)")
                }
                section.items.append(item)
            }
            return section
        }())
        
        // Add "Deletable with confirmation" section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection(headerTitle: "Deletable with confirmation")
            
            for i in 1...5 {
                let item = TableViewItem(text: "Section 2, Item \(i)")
                item.editingStyle = .Delete
                item.deletionHandlerWithCompletion = { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, completionHandler: ((Void) -> (Void))) in
                    let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete \(item.text)", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
                    alertController.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (action: UIAlertAction!) -> Void in
                        completionHandler()
                        print("Item removed: \(item.text)")
                    }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                section.items.append(item)
            }
            return section
        }())
        
        // Add "Movable" section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection(headerTitle: "Movable")
            
            for i in 1...5 {
                let item = TableViewItem(text: "Section 3, Item \(i)")
                item.editingStyle = .None
                item.moveHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> (Bool) in
                    return true
                }
                item.moveCompletionHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) in
                    print("Moved item: \(item.text) from [\(sourceIndexPath.section),\(sourceIndexPath.row)] to [\(destinationIndexPath.section),\(destinationIndexPath.row)]");
                }
                section.items.append(item)
            }
            return section
        }())
        
        // Add "Deletable & Movable" section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection(headerTitle: "Deletable & Movable")
            
            for i in 1...5 {
                let item = TableViewItem(text: "Section 4, Item \(i)")
                item.editingStyle = .Delete
                item.moveHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> (Bool) in
                    return true
                }
                item.moveCompletionHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) in
                    print("Moved item: \(item.text) from [\(sourceIndexPath.section),\(sourceIndexPath.row)] to [\(destinationIndexPath.section),\(destinationIndexPath.row)]");
                }
                section.items.append(item)
            }
            return section
        }())
        
        // Add "Can move only within this section" section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection(headerTitle: "Can move only within this section")
            
            for i in 1...5 {
                let item = TableViewItem(text: "Section 5, Item \(i)")
                item.moveHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> (Bool) in
                    return destinationIndexPath.section == sourceIndexPath.section;
                }
                section.items.append(item)
            }
            return section
        }())
        
        // Add "Insert editing style" section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection(headerTitle: "Insert editing style")
            
            let item = TableViewItem(text: "Section 6, Item 1")
            item.editingStyle = .Insert
            item.insertionHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                print("Insertion handler callback")
            }
            section.items.append(item)
            return section
        }())
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.setEditing(true, animated: true)
    }
}
