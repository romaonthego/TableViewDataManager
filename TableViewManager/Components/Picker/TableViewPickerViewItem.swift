//
//  TableViewPickerViewItem.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewPickerViewItem: TableViewFormItem {
    
    weak var pickerItem: TableViewPickerItem?
    
    // MARK: Handlers
    //
    var changeHandler: ((section: TableViewSection, item: TableViewPickerViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
}

