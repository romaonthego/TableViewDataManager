//
//  TableViewPickerCell.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewPickerCell: TableViewFormCell {
    
    // MARK: Public variables
    //
    public override var item: TableViewItem! { get { return pickerItem } set { pickerItem = newValue as! TableViewPickerItem } }
    
    // MARK: Private variables
    //
    private var pickerItem: TableViewPickerItem!
    
    private lazy var pickerViewItem: TableViewPickerViewItem = TableViewPickerViewItem()
    
    // MARK: View lifecycle
    //
    public override func cellDidLoad() {
        super.cellDidLoad()
        self.item.selectionHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
            let pickerItem = item as! TableViewPickerItem
            guard let indexOfItem = section.items.indexOf(item) else {
                return
            }
            let newItemIndexPath = NSIndexPath(forRow: indexOfItem + 1, inSection: indexPath.section)
            pickerItem.selected = newItemIndexPath.row < section.items.count && section.items[newItemIndexPath.row] is TableViewPickerViewItem
            if pickerItem.selected {
                section.items.removeAtIndex(newItemIndexPath.row)
                tableView.deleteRowsAtIndexPaths([newItemIndexPath], withRowAnimation: .Top)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            } else {
                section.items.insert(self.pickerViewItem, atIndex: newItemIndexPath.row)
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: newItemIndexPath.row, inSection: indexPath.section)], withRowAnimation: .Fade)
            }
        }
    }
    
    public override func cellWillAppear() {
        super.cellWillAppear()
        self.selectionStyle = .Default
        self.setSelected(self.pickerItem.selected, animated: false)
        self.pickerViewItem.pickerItem = self.pickerItem
        self.pickerViewItem.changeHandler = { [unowned self] (section: TableViewSection, item: TableViewPickerViewItem, tableView: UITableView, indexPath: NSIndexPath) in
            self.updateDetailLabelText()
        }
        updateDetailLabelText()
    }
    
    private func updateDetailLabelText() {
        guard let detailTextLabel = self.detailTextLabel else {
            return
        }
        
        if let value = self.pickerItem.value {
            detailTextLabel.text = value.joinWithSeparator(", ")
        } else {
            detailTextLabel.text = self.pickerItem.placeholder
        }
    }
    
}
