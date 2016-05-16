//
// TableViewSwitchCell.swift
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

public class TableViewSwitchCell: TableViewFormCell {

    // Public variables
    //
    public override var item: TableViewItem! { get { return switchItem } set { switchItem = newValue as! TableViewSwitchItem } }
    
    // Private variables
    //
    private var switchItem: TableViewSwitchItem!
    
    // Interface builder outlets
    //
    @IBOutlet public private(set) var switchControl: UISwitch!
    
    public override func cellDidLoad() {
        super.cellDidLoad()
    }
    
    public override func cellWillAppear() {
        super.cellWillAppear()
        self.switchControl.on = self.switchItem.value
    }
    
    @IBAction func switchValueChanged(sender: UISwitch!) {
        self.switchItem.value = sender.on
        guard let changeHandler = self.switchItem.changeHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath else {
            return
        }
        changeHandler(section: self.section, item: self.switchItem, tableView: tableView, indexPath: indexPath)
    }
    
}
