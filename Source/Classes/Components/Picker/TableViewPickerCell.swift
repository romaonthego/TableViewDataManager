//
// TableViewPickerCell.swift
// TableViewDataManager
//
// Copyright (c) 2016 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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
