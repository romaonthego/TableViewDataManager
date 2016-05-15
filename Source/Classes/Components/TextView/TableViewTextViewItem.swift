//
// TableViewTextViewItem.swift
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

public class TableViewTextViewItem: TableViewFormItem, TableViewItemFocusable {
    
    public var value: String?
    public var editable: Bool = true
    public var showsActionBar = true
    
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