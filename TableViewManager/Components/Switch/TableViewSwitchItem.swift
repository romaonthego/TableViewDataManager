//
//  TableViewSwitchItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/15/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewSwitchItem: TableViewFormItem {
    
    var value: Bool = true
    
    override class func focusable() -> Bool {
        return false
    }
    
    // MARK: Handlers
    //
    var changeHandler: ((section: TableViewSection, item: TableViewSwitchItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    
    // MARK: Instance Lifecycle
    //
    convenience init(text: String?, value: Bool) {
        self.init(text: text)
        self.value = value
    }
}
