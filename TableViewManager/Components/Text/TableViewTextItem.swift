//
//  TableViewTextItem.swift
//  Example
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewTextItem: TableViewItem {
   
    var value: String?
    var charactersLimit: Int?
    var returnKeyType: UIReturnKeyType = .Default
    var changeHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var changeCharacterInRangeHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, range: NSRange, replacementString: String) -> (Bool))?
    var returnKeyHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    
    override class func focusable() -> Bool {
        return true
    }
    
}
