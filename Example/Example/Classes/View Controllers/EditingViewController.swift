//
//  EditingViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/4/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

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
            
            for (var i = 1; i <= 5; i++) {
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
            
            for (var i = 1; i <= 5; i++) {
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
            
            for (var i = 1; i <= 5; i++) {
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
            
            for (var i = 1; i <= 5; i++) {
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
            
            for (var i = 1; i <= 5; i++) {
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
