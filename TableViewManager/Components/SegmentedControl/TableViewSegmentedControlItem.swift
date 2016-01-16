//
//  TableViewTextItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewSegmentedControlItem: TableViewFormItem {
   
    var value: Int?
    var items: [AnyObject]?
    
    override class func focusable() -> Bool {
        return false
    }
    
    // MARK: Handlers
    //
    var changeHandler: ((section: TableViewSection, item: TableViewSegmentedControlItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?

    // MARK: Instance Lifecycle
    //
    convenience init(text: String?, items: [AnyObject], value: Int) {
        self.init(text: text)
        self.items = items
        self.value = value
    }
}
