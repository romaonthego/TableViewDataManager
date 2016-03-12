//
//  TableViewPickerItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewPickerItem: TableViewFormItem {
   
    public var value: [String]?
    public var selected: Bool = false
    public var placeholder: String?
    public var options: [[String]]?
    
    // MARK: Instance Lifecycle
    //
    public convenience init(text: String?, placeholder: String?, value: [String]?, options: [[String]]?) {
        self.init(text: text)
        self.value = value
        self.placeholder = placeholder
        self.value = value
        self.options = options
    }
    
}
