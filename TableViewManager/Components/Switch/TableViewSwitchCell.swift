//
//  TableViewSwitchCell.swift
//  Example
//
//  Created by Roman Efimov on 3/15/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewSwitchCell: TableViewFormCell {

    // Public variables
    //
    override var item: TableViewItem! { get { return switchItem } set { switchItem = newValue as! TableViewSwitchItem } }
    
    // Private variables
    //
    private var switchItem: TableViewSwitchItem!
    
    // Interface builder outlets
    //
    @IBOutlet weak var switchControl: UISwitch!
    
    override func cellDidLoad() {
        super.cellDidLoad()
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        self.switchControl.on = self.switchItem.value
    }
    
    @IBAction func switchValueChanged(sender: UISwitch!) {
        self.switchItem.value = sender.on
    }
    
}
