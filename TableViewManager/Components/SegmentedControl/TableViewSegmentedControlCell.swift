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

    override func cellWillAppear() {
        super.cellWillAppear()
        self.segmentedControl.removeAllSegments()
        if let items = self.segmentedControlItem.items, let selectedSegmentIndex = self.segmentedControlItem.value {
            for (index, item) in items.enumerate() {
                switch item {
                case is String:
                    self.segmentedControl.insertSegmentWithTitle(item as? String, atIndex: index, animated: false)
                case is UIImage:
                    self.segmentedControl.insertSegmentWithImage(item as? UIImage, atIndex: index, animated: false)
                default:
                    continue
                }
            }
            self.segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        }
    }
    
    // MARK: Actions
    //
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl!) {
        self.segmentedControlItem.value = sender.selectedSegmentIndex
        guard let changeHandler = self.segmentedControlItem.changeHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath else {
            return
        }
        changeHandler(section: self.section, item: self.segmentedControlItem, tableView: tableView, indexPath: indexPath)
    }
}
