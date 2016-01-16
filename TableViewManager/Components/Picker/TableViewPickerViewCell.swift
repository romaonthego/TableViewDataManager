//
//  TableViewPickerViewCell.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewPickerViewCell: TableViewFormCell {

    // MARK: Public variables
    //
    override var item: TableViewItem! { get { return pickerViewItem } set { pickerViewItem = newValue as! TableViewPickerViewItem } }
    
    // MARK: Private variables
    //
    private var pickerViewItem: TableViewPickerViewItem!
    
    // MARK: Interface builder outlets
    //
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: View Lifecycle
    //
    override func cellWillAppear() {
        super.cellWillAppear()
//        guard let pickerItem = self.pickerViewItem.pickerItem, let value = pickerViewItem.value else {
//            return
//        }
//        
    }
    
    // MARK: Actions
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker!) {
//        if let dateTimeItem = self.datePickerItem.dateTimeItem {
//            dateTimeItem.value = sender.date
//        }
//        guard let changeHandler = self.datePickerItem.changeHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath else {
//            return
//        }
//        changeHandler(section: self.section, item: self.datePickerItem, tableView: tableView, indexPath: indexPath)
    }
    
}
