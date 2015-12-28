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
    
    // MARK: Interface builder outlets
    //
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: View Lifecycle
    //
    override func cellDidLoad() {
        super.cellDidLoad()
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let dateTimeItem = self.datePickerItem.dateTimeItem, let value = dateTimeItem.value else {
            return
        }
        self.datePicker.date = value
    }
    
    // MARK: Actions
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker!) {
        if let dateTimeItem = self.datePickerItem.dateTimeItem {
            dateTimeItem.value = sender.date
        }
        guard let changeHandler = self.datePickerItem.changeHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath else {
            return
        }
        changeHandler(section: self.section, item: self.datePickerItem, tableView: tableView, indexPath: indexPath)
    }
    
}
