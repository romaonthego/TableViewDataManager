//
//  TableViewTextViewCell.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewTextViewCell: TableViewFormCell, UITextViewDelegate {

    // MARK: Public variables
    //
    override var item: TableViewItem! { get { return textViewItem } set { textViewItem = newValue as! TableViewTextViewItem } }
    
    // MARK: Private variables
    //
    private var textViewItem: TableViewTextViewItem!
    
    // MARK: Interface builder outlets
    //
    @IBOutlet weak var textView: UITextView!
    
    // MARK: View Lifecycle
    //
    override func cellDidLoad() {
        super.cellDidLoad()
        self.textView.textContainer.lineFragmentPadding = 0
        self.textView.textContainerInset = UIEdgeInsetsZero
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
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
    
    // MARK: <UITextViewDelegate> methods
    //
    func textViewDidBeginEditing(textView: UITextView) {
        if let beginEditingHandler = self.textViewItem.beginEditingHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath {
            beginEditingHandler(section: self.section, item: self.textViewItem, tableView: tableView, indexPath: indexPath)
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if let endEditingHandler = self.textViewItem.endEditingHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath {
            endEditingHandler(section: self.section, item: self.textViewItem, tableView: tableView, indexPath: indexPath)
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if let returnKeyHandler = self.textViewItem.returnKeyHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath where text == "\n" {
            textView.resignFirstResponder()
            returnKeyHandler(section: self.section, item: self.textViewItem, tableView: tableView, indexPath: indexPath)
            return false
        }
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        self.textViewItem.value = textView.text
        if let changeHandler = self.textViewItem.changeHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath {
            changeHandler(section: self.section, item: self.textViewItem, tableView: tableView, indexPath: indexPath)
        }
    }
}
