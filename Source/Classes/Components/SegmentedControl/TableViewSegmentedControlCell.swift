//
// TableViewSegmentedControlCell.swift
// TableViewManager
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

public class TableViewSegmentedControlCell: TableViewFormCell {

    // Public variables
    //
    public override var item: TableViewItem! { get { return segmentedControlItem } set { segmentedControlItem = newValue as! TableViewSegmentedControlItem } }
    
    // Private variables
    //
    private var segmentedControlItem: TableViewSegmentedControlItem!
    
    // Interface builder outlets
    //
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    public override func cellWillAppear() {
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
