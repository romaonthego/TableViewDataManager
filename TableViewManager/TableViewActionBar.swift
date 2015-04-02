//
//  TableViewActionBar.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewActionBar: UIToolbar {

    var navigationControl: UISegmentedControl!
    var navigationHandler: ((index: Int) -> (Void))?
    var doneHandler: ((Void) -> (Void))?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    required init(navigationHandler: ((index: Int) -> (Void)), doneHandler: ((Void) -> (Void))) {
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
            control.addTarget(self, action: Selector("previousNextPressed:"), forControlEvents: .ValueChanged)
            control.setWidth(40, forSegmentAtIndex: 0)
            control.setWidth(40, forSegmentAtIndex: 1)
            control.setContentOffset(CGSize(width: -4, height: 0), forSegmentAtIndex: 0)
            control.setImage(UIImage(named: "UIButtonBarArrowLeft"), forSegmentAtIndex: 0)
            control.setImage(UIImage(named: "UIButtonBarArrowRight"), forSegmentAtIndex: 1)
            control.setBackgroundImage(UIImage(named: "Transparent"), forState: .Normal, barMetrics: .Default)
            return control
        }()
        self.items = [
            UIBarButtonItem(customView: self.navigationControl),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("doneButtonPressed:"))
        ]
    }
    
    // MARK: Action handlers
    //
    func previousNextPressed(segmentedControl: UISegmentedControl) {
        if let navigationHandler = self.navigationHandler {
            navigationHandler(index: segmentedControl.selectedSegmentIndex)
        }
    }
    
    func doneButtonPressed(sender: AnyObject) {
        if let doneHandler = self.doneHandler {
            doneHandler()
        }
    }

}
