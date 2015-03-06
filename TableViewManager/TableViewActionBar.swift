//
//  TableViewActionBar.swift
//  Example
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewActionBar: UIToolbar {

    var navigationControl: UISegmentedControl!
    var navigationHandler: ((index: Int) -> (Void))?
    var doneHandler: ((Void) -> (Void))?
    
    override init() {
        super.init()
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    required init(navigationHandler: ((index: Int) -> (Void)), doneHandler: ((Void) -> (Void))) {
        super.init()
        self.navigationHandler = navigationHandler
        self.doneHandler = doneHandler
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
        var closure: ((Void) -> (Void)) = {
            if let doneHandler = self.doneHandler {
                
            }
        }
        closure()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    /*
    [self sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleActionBarDone:)];
    
    self.navigationControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous", @""), NSLocalizedString(@"Next", @""), nil]];
    self.navigationControl.momentary = YES;
    [self.navigationControl addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationControl setImage:[UIImage imageNamed:@"RETableViewManager.bundle/UIButtonBarArrowLeft"] forSegmentAtIndex:0];
    [self.navigationControl setImage:[UIImage imageNamed:@"RETableViewManager.bundle/UIButtonBarArrowRight"] forSegmentAtIndex:1];
    
    
    [self.navigationControl setBackgroundImage:[UIImage imageNamed:@"RETableViewManager.bundle/Transparent"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationControl setWidth:40.0f forSegmentAtIndex:0];
    [self.navigationControl setWidth:40.0f forSegmentAtIndex:1];
    [self.navigationControl setContentOffset:CGSizeMake(-4, 0) forSegmentAtIndex:0];
    
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:self.navigationControl];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
    self.actionBarDelegate = delegate;
    */

}
