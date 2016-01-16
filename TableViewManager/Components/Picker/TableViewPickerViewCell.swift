//
//  TableViewPickerViewCell.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewPickerViewCell: TableViewFormCell, UIPickerViewDelegate, UIPickerViewDataSource {

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
        guard let pickerItem = self.pickerViewItem.pickerItem, let value = pickerItem.value, let options = pickerItem.options else {
            return
        }
        for (component, item) in options.enumerate() {
            if let index = item.indexOf(value[component]) {
                self.pickerView.selectRow(index, inComponent: component, animated: false)
            }
        }
        
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
    
    // MARK: <UIPickerViewDelegate> methods
    //
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let pickerItem = self.pickerViewItem.pickerItem, options = pickerItem.options else {
            return nil
        }
        return options[component][row]
    }
    
    // MARK: <UIPickerViewDataSource> methods
    //
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        guard let pickerItem = self.pickerViewItem.pickerItem, options = pickerItem.options else {
            return 0
        }
        return options.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let pickerItem = self.pickerViewItem.pickerItem, options = pickerItem.options else {
            return 0
        }
        return options[component].count
    }
    
}
