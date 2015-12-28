//
//  TableViewTextViewCell.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewTextViewCell: TableViewFormCell {

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
}
