//
//  TableViewItem.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewItem {
    
    var text: String?
    var detailText: String?
    var configurationHandler: ((tableViewCell: TableViewCell) -> (Void))?
    
    init() {}
    
    init(text: String) {
        self.text = text
    }
    
}