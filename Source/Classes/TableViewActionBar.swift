//
// TableViewActionBar.swift
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

public class TableViewActionBar: UIToolbar {

    public var navigationControl: UISegmentedControl!
    public var navigationHandler: ((index: Int) -> (Void))?
    public var doneHandler: ((Void) -> (Void))?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    public required init(navigationHandler: ((index: Int) -> (Void)), doneHandler: ((Void) -> (Void))) {
        super.init(frame: CGRectNull)
        self.navigationHandler = navigationHandler
        self.doneHandler = doneHandler
        self.commonInit()
    }
    
    // MARK: Private methods
    //
    private func commonInit() {
        self.sizeToFit()
        self.navigationControl = {
            let control = UISegmentedControl(items: ["Previous", "Next"])
            control.momentary = true
            control.setDividerImage(UIImage(), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
            control.addTarget(self, action: #selector(TableViewActionBar.previousNextPressed(_:)), forControlEvents: .ValueChanged)
            control.setWidth(40, forSegmentAtIndex: 0)
            control.setWidth(40, forSegmentAtIndex: 1)
            control.setContentOffset(CGSize(width: -4, height: 0), forSegmentAtIndex: 0)
            control.setImage(UIImage(named: "TableViewDataManager.bundle/UIButtonBarArrowLeft", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil), forSegmentAtIndex: 0)
            control.setImage(UIImage(named: "TableViewDataManager.bundle/UIButtonBarArrowRight", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil), forSegmentAtIndex: 1)
            control.setBackgroundImage(UIImage(named: "TableViewDataManager.bundle/Transparent", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil), forState: .Normal, barMetrics: .Default)
            return control
        }()
        self.items = [
            UIBarButtonItem(customView: self.navigationControl),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(TableViewActionBar.doneButtonPressed(_:)))
        ]
    }
    
    // MARK: Action handlers
    //
    public func previousNextPressed(segmentedControl: UISegmentedControl) {
        if let navigationHandler = self.navigationHandler {
            navigationHandler(index: segmentedControl.selectedSegmentIndex)
        }
    }
    
    public func doneButtonPressed(sender: AnyObject) {
        if let doneHandler = self.doneHandler {
            doneHandler()
        }
    }

}
