//
//  TableViewPickerViewCell.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewPickerViewCell: TableViewFormCell, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: Public variables
    //
    public override var item: TableViewItem! { get { return pickerViewItem } set { pickerViewItem = newValue as! TableViewPickerViewItem } }
    
    // MARK: Private variables
    //
    private var pickerViewItem: TableViewPickerViewItem!
    
    // MARK: Interface builder outlets
    //
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: View Lifecycle
    //
    public override func cellWillAppear() {
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
    
    // MARK: <UIPickerViewDelegate> methods
    //
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let pickerItem = self.pickerViewItem.pickerItem, options = pickerItem.options else {
            return nil
        }
        return options[component][row]
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerItem = self.pickerViewItem.pickerItem, options = pickerItem.options {
            pickerItem.value = {
                var value : [String] = []
                for (component, item) in options.enumerate() {
                    value.append(item[pickerView.selectedRowInComponent(component)])
                }
                return value
            }()
        }
        guard let changeHandler = self.pickerViewItem.changeHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath else {
            return
        }
        changeHandler(section: self.section, item: self.pickerViewItem, tableView: tableView, indexPath: indexPath)
    }
    
    // MARK: <UIPickerViewDataSource> methods
    //
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        guard let pickerItem = self.pickerViewItem.pickerItem, options = pickerItem.options else {
            return 0
        }
        return options.count
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let pickerItem = self.pickerViewItem.pickerItem, options = pickerItem.options else {
            return 0
        }
        return options[component].count
    }
    
}
