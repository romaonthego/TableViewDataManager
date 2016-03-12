//
//  TableViewSliderItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewSliderItem: TableViewFormItem {
   
    public var value: Float = 0
    
    // MARK: Handlers
    //
    public var changeHandler: ((section: TableViewSection, item: TableViewSliderItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    
    // MARK: Instance Lifecycle
    //
    public convenience init(text: String?, value: Float) {
        self.init(text: text)
        self.value = value
    }
}
