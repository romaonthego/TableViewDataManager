//
//  TableViewSwitchItem.swift
//  Example
//
//  Created by Roman Efimov on 3/15/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewSwitchItem: TableViewFormItem {
    
    var value: Bool = true
    
    // MARK: Instance Lifecycle
    //
    convenience init(text: String?, value: Bool) {
        self.init(text: text)
        self.value = value
    }
}
