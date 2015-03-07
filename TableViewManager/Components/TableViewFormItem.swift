//
//  TableViewFormItem.swift
//  Example
//
//  Created by Roman Efimov on 3/6/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewFormItem: TableViewItem {
   
    // Handlers
    //
    var changeHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    
    override class func focusable() -> Bool {
        return true
    }
    
}
