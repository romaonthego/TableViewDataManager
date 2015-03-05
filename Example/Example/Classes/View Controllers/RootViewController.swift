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
                TableViewItem(text: "! Forms", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Style", sender: nil)
                }),
                TableViewItem(text: "! List", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Style", sender: nil)
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
                TableViewItem(text: "Interface Builder Support", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Interface Builder Support", sender: nil)
                }),
                TableViewItem(text: "Indexed List", selectionHandler: { [unowned self] (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    self.performSegueWithIdentifier("Root → Show Indexed List", sender: nil)
                })
            ]
            
            return section
        }())
    }
}
