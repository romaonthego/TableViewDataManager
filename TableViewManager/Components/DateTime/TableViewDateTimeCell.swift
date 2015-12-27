//
//  TableViewDateCell.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewDateTimeCell: TableViewFormCell {
    
    override func cellDidLoad() {
        super.cellDidLoad()
        self.item.selectionHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
