//
//  TableViewItem.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewItem: NSObject, UIAccessibilityIdentification {
    
    var text: String?
    var detailText: String?
    var configurationHandler: ((tableViewCell: TableViewCell) -> (Void))?
    var accessibilityIdentifier: String?
    
    init(text: String) {
        self.text = text
    }
    
}