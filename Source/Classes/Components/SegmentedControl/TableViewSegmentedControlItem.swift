//
//  TableViewTextItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewSegmentedControlItem: TableViewFormItem {
   
    public var value: Int?
    public var items: [AnyObject]?
    
    // MARK: Handlers
    //
    public var changeHandler: ((section: TableViewSection, item: TableViewSegmentedControlItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?

    // MARK: Instance Lifecycle
    //
    public convenience init(text: String?, items: [AnyObject], value: Int) {
        self.init(text: text)
        self.items = items
        self.value = value
    }
}
