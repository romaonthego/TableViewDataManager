//
//  TableViewTextItem.swift
//  Example
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewTextItem: TableViewFormItem {
   
    var value: String?
    var placeholder: String?
    var charactersLimit: Int?
    var secureTextEntry = false
    
    // Keyboard
    //
    var autocapitalizationType = UITextAutocapitalizationType.Sentences // default is UITextAutocapitalizationTypeSentences
    var autocorrectionType = UITextAutocorrectionType.Default // default is UITextAutocorrectionTypeDefault
    var spellCheckingType = UITextSpellCheckingType.Default // default is UITextSpellCheckingTypeDefault
    var keyboardType = UIKeyboardType.Default // default is UIKeyboardTypeDefault
    var keyboardAppearance = UIKeyboardAppearance.Default // default is UIKeyboardAppearanceDefault
    var returnKeyType = UIReturnKeyType.Default // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
    var enablesReturnKeyAutomatically = false // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)

    // Handlers
    //
    var changeCharacterInRangeHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, range: NSRange, replacementString: String) -> (Bool))?
    var returnKeyHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
}
