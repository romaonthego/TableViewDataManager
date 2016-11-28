//
// TableViewTextCell.swift
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

public class TableViewTextFieldCell: TableViewFormCell, UITextFieldDelegate {

    // Public variables
    //
    public override var item: TableViewItem! { get { return textItem } set { textItem = newValue as! TableViewTextFieldItem } }
    
    // Private variables
    //
    private var textItem: TableViewTextFieldItem!
    
    // Interface builder outlets
    //
    @IBOutlet public private(set) var textField: UITextField!

    public override func cellDidLoad() {
        super.cellDidLoad()
        self.textField.addTarget(self, action: #selector(TableViewTextFieldCell.textFieldDidChange(_:)), forControlEvents: .EditingChanged)
    }
    
    public override func cellWillAppear() {
        super.cellWillAppear()
        self.textField.inputAccessoryView = self.textItem.showsActionBar ? self.actionBar : nil
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
       
    public override func responder() -> UIResponder? {
        return self.textField
    }
    
    // MARK: Text field delegate
    //
    public func textFieldDidChange(textField: UITextField) {
        self.textItem.value = textField.text
        if let changeHandler = self.textItem.changeHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath {
            changeHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath)
        }
    }
    
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if let _ = self.indexPathForNextResponder() {
            textField.returnKeyType = .Next
        } else {
            textField.returnKeyType = self.textItem.returnKeyType
        }
        self.updateActionBarNavigationControl()
        if let editingHandler = self.textItem.editingHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath {
            editingHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath, status: .WillBeginEditing)
        }
        return true
    }
    
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if let editingHandler = self.textItem.editingHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath {
            editingHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath, status: .DidEndEditing)
        }
        return true
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let returnKeyHandler = self.textItem.returnKeyHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath {
            returnKeyHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath)
        }
        if let editingHandler = self.textItem.editingHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath {
            editingHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath, status: .DidEndEditing)
        }
        if let _ = self.indexPathForNextResponder() {
            self.endEditing(true)
            return true
        }
        if let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath, let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.becomeFirstResponder()
        }
        return true
    }
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var shouldChange = true
        if let charactersLimit = self.textItem.charactersLimit {
            let newLength = textField.text!.characters.count + string.characters.count - range.length
            shouldChange = newLength <= charactersLimit
        }
        if let changeCharacterInRangeHandler = self.textItem.changeCharacterInRangeHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath {
            shouldChange = changeCharacterInRangeHandler(section: self.section, item: self.textItem, tableView: tableView, indexPath: indexPath, range: range, replacementString: string)
        }
        return shouldChange
    }
}
