//
// TableViewSliderCell.swift
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

public class TableViewSliderCell: TableViewFormCell {

    // MARK: Public variables
    //
    public override var item: TableViewItem! { get { return sliderItem } set { sliderItem = newValue as! TableViewSliderItem } }
    
    // MARK: Private variables
    //
    private var sliderItem: TableViewSliderItem!
    
    // MARK: Interface builder outlets
    //
    @IBOutlet var slider: UISlider!
    
    // MARK: View Lifecycle
    //
    public override func cellDidLoad() {
        super.cellDidLoad()
    }
    
    public override func cellWillAppear() {
        super.cellWillAppear()
        slider.value = self.sliderItem.value
    }
    
    // MARK: Actions
    //
    @IBAction func sliderValueChanged(sender: UISlider!) {
        self.sliderItem.value = sender.value
        guard let changeHandler = self.sliderItem.changeHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath else {
            return
        }
        changeHandler(section: self.section, item: self.sliderItem, tableView: tableView, indexPath: indexPath)
    }
}
