//
//  TableViewDateCell.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewDateTimeCell: TableViewFormCell {
    
    // MARK: Public variables
    //
    override var item: TableViewItem! { get { return dateTimeItem } set { dateTimeItem = newValue as! TableViewDateTimeItem } }
    
    // MARK: Private variables
    //
    private var dateTimeItem: TableViewDateTimeItem!
    
    private lazy var datePickerItem: TableViewDatePickerItem = TableViewDatePickerItem()
    
    // MARK: View lifecycle
    //
    override func cellDidLoad() {
        super.cellDidLoad()
        self.item.selectionHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
            let dateTimeItem = item as! TableViewDateTimeItem
            guard let indexOfItem = section.items.indexOf(item) else {
                return
            }
            let newItemIndexPath = NSIndexPath(forRow: indexOfItem + 1, inSection: indexPath.section)
            dateTimeItem.selected = newItemIndexPath.row < section.items.count && section.items[newItemIndexPath.row] is TableViewDatePickerItem
            if dateTimeItem.selected {
                section.items.removeAtIndex(newItemIndexPath.row)
                tableView.deleteRowsAtIndexPaths([newItemIndexPath], withRowAnimation: .Automatic)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            } else {
                section.items.insert(self.datePickerItem, atIndex: newItemIndexPath.row)
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: newItemIndexPath.row, inSection: indexPath.section)], withRowAnimation: .Automatic)
            }
        }
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        self.selectionStyle = .Default
        

        
        self.setSelected(self.dateTimeItem.selected, animated: false)
        self.datePickerItem.dateTimeItem = self.dateTimeItem
        self.datePickerItem.changeHandler = { [weak self] (section: TableViewSection, item: TableViewDatePickerItem, tableView: UITableView, indexPath: NSIndexPath) in
            self.updateDetailLabelText()
        }
        
        updateDetailLabelText()
    }
    
    private func updateDetailLabelText() {
        guard let detailTextLabel = self.detailTextLabel else {
            return
        }
        
        if let value = self.dateTimeItem.value {
            detailTextLabel.text = self.dateTimeItem.dateFormatter.stringFromDate(value)
        } else {
            detailTextLabel.text = self.dateTimeItem.placeholder
        }
    }
    
}
