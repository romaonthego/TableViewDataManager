//
//  TableViewTextViewItem.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewTextViewItem: TableViewFormItem {
    
    var value: String?
    var editable: Bool = true
    
    // MARK: Keyboard
    //
    var autocapitalizationType = UITextAutocapitalizationType.Sentences // default is UITextAutocapitalizationTypeSentences
    var autocorrectionType = UITextAutocorrectionType.Default // default is UITextAutocorrectionTypeDefault
    var spellCheckingType = UITextSpellCheckingType.Default // default is UITextSpellCheckingTypeDefault
    var keyboardType = UIKeyboardType.Default // default is UIKeyboardTypeDefault
    var keyboardAppearance = UIKeyboardAppearance.Default // default is UIKeyboardAppearanceDefault
    var returnKeyType = UIReturnKeyType.Default // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
    var enablesReturnKeyAutomatically = false // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
    
    // MARK: Handlers
    //
    var changeHandler: ((section: TableViewSection, item: TableViewTextViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var beginEditingHandler: ((section: TableViewSection, item: TableViewTextViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var endEditingHandler: ((section: TableViewSection, item: TableViewTextViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var returnKeyHandler: ((section: TableViewSection, item: TableViewTextViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    
    // MARK: Instance Lifecycle
    //
    convenience init(text: String?, value: String?) {
        self.init(text: text)
        self.value = value
    }
}