//
//  TableViewTextItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewTextFieldItem: TableViewFormItem, TableViewItemFocusable {
   
    public var value: String?
    public var placeholder: String?
    public var charactersLimit: Int?
    public var secureTextEntry = false
    
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
    public var changeHandler: ((section: TableViewSection, item: TableViewTextFieldItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var changeCharacterInRangeHandler: ((section: TableViewSection, item: TableViewTextFieldItem, tableView: UITableView, indexPath: NSIndexPath, range: NSRange, replacementString: String) -> (Bool))?
    public var returnKeyHandler: ((section: TableViewSection, item: TableViewTextFieldItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?

    // MARK: Instance Lifecycle
    //
    public convenience init(text: String?, placeholder: String?, value: String?) {
        self.init(text: text)
        self.placeholder = placeholder
        self.value = value
    }
}
