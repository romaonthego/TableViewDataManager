//
//  TableViewPickerItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewPickerItem: TableViewFormItem {
   
    var value: [String]?
    var selected: Bool = false
    var placeholder: String?
    var options: [[String]]?
    
    // MARK: Instance Lifecycle
    //
    convenience init(text: String?, placeholder: String?, value: [String]?, options: [[String]]?) {
        self.init(text: text)
        self.value = value
        self.placeholder = placeholder
        self.value = value
        self.options = options
    }
    
}
