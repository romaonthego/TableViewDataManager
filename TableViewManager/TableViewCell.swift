//
//  TableViewCell.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var item: TableViewItem!
    var section: TableViewSection!
    var indexPath: NSIndexPath?
    
    func cellWillAppear() {
        self.textLabel?.text = item.text
    }
    
    func heightWithItem(item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> Float {
        return item.height
    }
}
