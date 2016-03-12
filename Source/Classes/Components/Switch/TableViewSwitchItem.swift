//
//  TableViewSwitchItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/15/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewSwitchItem: TableViewFormItem {
    
    public var value: Bool = true
    
    // MARK: Handlers
    //
    public var changeHandler: ((section: TableViewSection, item: TableViewSwitchItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    
    // MARK: Instance Lifecycle
    //
    public convenience init(text: String?, value: Bool) {
        self.init(text: text)
        self.value = value
    }
}
