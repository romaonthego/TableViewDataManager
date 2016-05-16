//
// TableViewTextViewCell.swift
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

public class TableViewTextViewCell: TableViewFormCell, UITextViewDelegate {

    // MARK: Public variables
    //
    public override var item: TableViewItem! { get { return textViewItem } set { textViewItem = newValue as! TableViewTextViewItem } }
    
    // MARK: Private variables
    //
    private var textViewItem: TableViewTextViewItem!
    
    // MARK: Interface builder outlets
    //
    @IBOutlet public private(set) var textView: UITextView!
    
    // MARK: View Lifecycle
    //
    public override func cellDidLoad() {
        super.cellDidLoad()
        self.textView.textContainer.lineFragmentPadding = 0
        self.textView.textContainerInset = UIEdgeInsetsZero
    }
    
    public override func cellWillAppear() {
        super.cellWillAppear()
        self.textView.inputAccessoryView = self.textViewItem.showsActionBar ? self.actionBar : nil
        self.textView.editable = textViewItem.editable
        self.textView.text = textViewItem.value
        self.textView.autocapitalizationType = self.textViewItem.autocapitalizationType
        self.textView.autocorrectionType = self.textViewItem.autocorrectionType
        self.textView.spellCheckingType = self.textViewItem.spellCheckingType
        self.textView.keyboardType = self.textViewItem.keyboardType
        self.textView.keyboardAppearance = self.textViewItem.keyboardAppearance
        self.textView.returnKeyType = self.textViewItem.returnKeyType
        self.textView.enablesReturnKeyAutomatically = self.textViewItem.enablesReturnKeyAutomatically
    }
    
    public override func responder() -> UIResponder? {
        return self.textView
    }
    
    // MARK: <UITextViewDelegate> methods
    //
    public func textViewDidBeginEditing(textView: UITextView) {
        if let beginEditingHandler = self.textViewItem.beginEditingHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath {
            beginEditingHandler(section: self.section, item: self.textViewItem, tableView: tableView, indexPath: indexPath)
        }
        self.updateActionBarNavigationControl()
    }
    
    public func textViewDidEndEditing(textView: UITextView) {
        if let endEditingHandler = self.textViewItem.endEditingHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath {
            endEditingHandler(section: self.section, item: self.textViewItem, tableView: tableView, indexPath: indexPath)
        }
    }
    
    public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if let returnKeyHandler = self.textViewItem.returnKeyHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath where text == "\n" {
            textView.resignFirstResponder()
            returnKeyHandler(section: self.section, item: self.textViewItem, tableView: tableView, indexPath: indexPath)
            return false
        }
        return true
    }
    
    public func textViewDidChange(textView: UITextView) {
        self.textViewItem.value = textView.text
        if let changeHandler = self.textViewItem.changeHandler, let tableView = self.tableViewDataManager.tableView, let indexPath = self.indexPath {
            changeHandler(section: self.section, item: self.textViewItem, tableView: tableView, indexPath: indexPath)
        }
    }
}
