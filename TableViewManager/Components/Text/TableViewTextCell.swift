//
//  TableViewTextCell.swift
//  Example
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewTextCell: TableViewFormCell, UITextFieldDelegate {

    // Public variables
    //
    override var item: TableViewItem! { get { return textItem } set { textItem = newValue as! TableViewTextItem } }
    
    // Private variables
    //
    private var textItem: TableViewTextItem!
    
    // Interface builder outlets
    //
    @IBOutlet weak var textField: UITextField!

    override func cellDidLoad() {
        super.cellDidLoad()
        self.textField.inputAccessoryView = self.actionBar
        self.textField.addTarget(self, action: Selector("textFieldDidChange:"), forControlEvents: .EditingChanged)
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        self.textField.text = self.textItem.value
        self.textField.placeholder = self.textItem.placeholder
        self.textField.secureTextEntry = self.textItem.secureTextEntry
        self.textField.autocapitalizationType = self.textItem.autocapitalizationType
        self.textField.autocorrectionType = self.textItem.autocorrectionType
        self.textField.spellCheckingType = self.textItem.spellCheckingType
        self.textField.keyboardType = self.textItem.keyboardType
        self.textField.keyboardAppearance = self.textItem.keyboardAppearance
        self.textField.returnKeyType = self.textItem.returnKeyType
        self.textField.enablesReturnKeyAutomatically = self.textItem.enablesReturnKeyAutomatically
    }
       
    override func responder() -> UIResponder? {
        return self.textField
    }
    
    // MARK: Text field delegate
    //
    func textFieldDidChange(textField: UITextField) {
        self.textItem.value = textField.text
        if let changeHandler = self.textItem.changeHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath {
            changeHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath)
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if let indexPath = self.indexPathForNextResponder() {
            textField.returnKeyType = .Next
        } else {
            textField.returnKeyType = self.textItem.returnKeyType
        }
        self.updateActionBarNavigationControl()
        if let editingHandler = self.textItem.editingHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath {
            editingHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath, status: .WillBeginEditing)
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if let editingHandler = self.textItem.editingHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath {
            editingHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath, status: .DidEndEditing)
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let returnKeyHandler = self.textItem.returnKeyHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath {
            returnKeyHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath)
        }
        if let editingHandler = self.textItem.editingHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath {
            editingHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath, status: .DidEndEditing)
        }
        let indexPath = self.indexPathForNextResponder()
        if indexPath != nil {
            self.endEditing(true)
            return true
        }
        if let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath, let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.becomeFirstResponder()
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var shouldChange = true
        if let charactersLimit = self.textItem.charactersLimit {
            let newLength = count(textField.text) + count(string) - range.length
            shouldChange = newLength <= charactersLimit
        }
        if let changeCharacterInRangeHandler = self.textItem.changeCharacterInRangeHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath {
            shouldChange = changeCharacterInRangeHandler(section: self.section, item: self.item, tableView: tableView, indexPath: indexPath, range: range, replacementString: string)
        }
        return shouldChange
    }
}
