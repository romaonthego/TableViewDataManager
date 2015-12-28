//
//  TableViewTextItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewSegmentedControlItem: TableViewFormItem {
   
    var value: Int?

    // MARK: Instance Lifecycle
    //
    convenience init(text: String?, value: Int?) {
        self.init(text: text)
        self.value = value
    }
}
