//
//  StyleViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/4/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class StyleViewController: UITableViewController {

    // Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = {
        let manager = TableViewManager(tableView: self.tableView)
        manager.style = {
            let style = TableViewCellStyle()
            style.setBackgroundColor(UIColor.redColor().colorWithAlphaComponent(0.3), forCellType: .First)
            style.setBackgroundImage(UIImage(named: "Background1")!, forCellType: .Middle)
            style.setBackgroundColor(UIColor.blueColor().colorWithAlphaComponent(0.3), forCellType: .Last)
            style.setSelectedBackgroundImage(UIImage(named: "Background2")!, forCellType: .Any)
            return style
        }()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.manager.dataSource!.sections.append({
            let section = TableViewSection()
            for i in 1...10 {
                section.items.append(TableViewItem(text: "\(i)", selectionHandler: { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) in
                    tableView.deselectRowAtIndexPath(indexPath, animated: true)
                }))
            }
            return section
        }())
    }
}
