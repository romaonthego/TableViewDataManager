//
//  TableViewDatePickerItem.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewDatePickerItem: TableViewFormItem {
    
    weak var dateTimeItem: TableViewDateTimeItem?
    
    // MARK: Handlers
    //
    var changeHandler: ((section: TableViewSection, item: TableViewDatePickerItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    
    override class func focusable() -> Bool {
        return false
    }
}

