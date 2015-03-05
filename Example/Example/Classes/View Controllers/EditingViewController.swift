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
                    println("Item removed: \(item.text)")
                }
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
                    var alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete \(item.text)", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
                    alertController.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (action: UIAlertAction!) -> Void in
                        completionHandler()
                        println("Item removed: \(item.text)")
                    }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
            
            return section
        }())
    }

}
