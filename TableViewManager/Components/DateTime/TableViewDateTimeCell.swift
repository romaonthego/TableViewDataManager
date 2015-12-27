//
//  TableViewDateCell.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewDateTimeCell: TableViewFormCell {
    
    lazy var datePickerItem: TableViewDatePickerItem = {
        let item = TableViewDatePickerItem()
        return item
    }()
    
    override func cellDidLoad() {
        super.cellDidLoad()
        self.item.selectionHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
            // tableView.deselectRowAtIndexPath(indexPath, animated: true)
            guard let indexOfItem = section.items.indexOf(item) else {
                return
            }
            section.items.insert(self.datePickerItem, atIndex: indexOfItem + 1)
            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: indexOfItem + 1, inSection: indexPath.section)], withRowAnimation: .Automatic)
        }
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        self.selectionStyle = .Default
        
        guard let detailTextLabel = self.detailTextLabel else {
            return
        }
        
        detailTextLabel.text = "123"
    }
}
