//
//  TableViewTextViewItem.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewTextViewItem: TableViewFormItem, TableViewItemFocusable {
    
    public var value: String?
    public var editable: Bool = true
    
    // MARK: Keyboard
    //
    public var autocapitalizationType = UITextAutocapitalizationType.Sentences // default is UITextAutocapitalizationTypeSentences
    public var autocorrectionType = UITextAutocorrectionType.Default // default is UITextAutocorrectionTypeDefault
    public var spellCheckingType = UITextSpellCheckingType.Default // default is UITextSpellCheckingTypeDefault
    public var keyboardType = UIKeyboardType.Default // default is UIKeyboardTypeDefault
    public var keyboardAppearance = UIKeyboardAppearance.Default // default is UIKeyboardAppearanceDefault
    public var returnKeyType = UIReturnKeyType.Default // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
    public var enablesReturnKeyAutomatically = false // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
    
    // MARK: Handlers
    //
    public var changeHandler: ((section: TableViewSection, item: TableViewTextViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var beginEditingHandler: ((section: TableViewSection, item: TableViewTextViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var endEditingHandler: ((section: TableViewSection, item: TableViewTextViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var returnKeyHandler: ((section: TableViewSection, item: TableViewTextViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    
    // MARK: Instance Lifecycle
    //
    public convenience init(text: String?, value: String?) {
        self.init(text: text)
        self.value = value
    }
}