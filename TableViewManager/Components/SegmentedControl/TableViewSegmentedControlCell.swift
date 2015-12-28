//
//  TableViewSegmentedControlCell.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewSegmentedControlCell: TableViewFormCell {

    // Public variables
    //
    override var item: TableViewItem! { get { return segmentedControlItem } set { segmentedControlItem = newValue as! TableViewSegmentedControlItem } }
    
    // Private variables
    //
    private var segmentedControlItem: TableViewSegmentedControlItem!
    
    // Interface builder outlets
    //
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func cellDidLoad() {
        super.cellDidLoad()
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
    }
}
