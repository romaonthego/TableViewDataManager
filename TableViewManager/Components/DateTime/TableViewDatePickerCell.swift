//
//  TableViewDatePickerCell.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewDatePickerCell: TableViewFormCell {

    // MARK: Public variables
    //
    override var item: TableViewItem! { get { return datePickerItem } set { datePickerItem = newValue as! TableViewDatePickerItem } }
    
    // MARK: Private variables
    //
    private var datePickerItem: TableViewDatePickerItem!
    
    // MARK: View Lifecycle
    //
    override func cellDidLoad() {
        super.cellDidLoad()
    }
    
}
