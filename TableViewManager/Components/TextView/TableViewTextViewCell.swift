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
    
}
