//
//  TableViewTextCell.swift
//  Example
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewTextCell: TableViewCell, UITextFieldDelegate {

    // Public variables
    //
    override var item: TableViewItem! { get { return textItem } set { textItem = newValue as! TableViewTextItem } }
    
    // Private variables
    //
    private var textItem: TableViewTextItem!
    
    // Interface builder outlets
    //
    @IBOutlet weak var labelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    override func cellDidLoad() {
        super.cellDidLoad()
        self.textField.inputAccessoryView = self.actionBar
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        // Fix label center Y
        //
        self.labelCenterYConstraint.constant = 0.5
    }
    
    override func responder() -> UIResponder? {
        return self.textField
    }
    
    // MARK: Text field delegate
    //
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if let indexPath = self.indexPathForNextResponder() {
            textField.returnKeyType = .Next
        } else {
            textField.returnKeyType = self.textItem.returnKeyType
        }
        self.updateActionBarNavigationControl()
        
        return true
        /*
        NSIndexPath *indexPath = [self indexPathForNextResponder];
        if (indexPath) {
            textField.returnKeyType = UIReturnKeyNext;
        } else {
            textField.returnKeyType = self.item.returnKeyType;
        }
        [self updateActionBarNavigationControl];
        [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.rowIndex inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        if (self.item.onBeginEditing)
        self.item.onBeginEditing(self.item);
        return YES;
        */
    }
    
}
