//
//  ViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TestViewController: UITableViewController {
    
    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = {
        let manager = TableViewManager(tableView: self.tableView)
        manager.registerNib(UINib(nibName: "IBTableViewCell", bundle: NSBundle.mainBundle()), forItemClass: IBTableViewItem.self)
        return manager
    }()
    
    // MARK: View life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection(headerTitle: "Section title")
            
            // Add items
            //
            section.items = [{
                let item = TableViewItem(text: "First item", configurationHandler:{ (tableViewCell: TableViewCell) in
                    tableViewCell.textLabel?.font = UIFont.boldSystemFontOfSize(20)
                }, selectionHandler: { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    tableView.deselectRowAtIndexPath(indexPath, animated: true)
                })
                return item
            }(), {
                let item = IBTableViewItem(text: "Second item")
                item.height = 100
                return item
            }()]
            
            return section
        }())
        
        // Add another section
        //
        self.manager.dataSource!.sections.append({
            let section = TableViewSection(headerView: {
                let view = UIView(frame: CGRectMake(0, 0, 0, 40))
                view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
                return view
            }())
            
            // Add items
            //
            section.items = [{
                let item = TableViewItem(text: "First item", configurationHandler:{ (tableViewCell: TableViewCell) in
                    tableViewCell.textLabel?.font = UIFont.boldSystemFontOfSize(20)
                }, selectionHandler: { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    tableView.deselectRowAtIndexPath(indexPath, animated: true)
                })
                return item
            }(), {
                let item = IBTableViewItem(text: "Second item")
                item.height = 100
                return item
            }()]
    
            return section
        }())
    }
}

