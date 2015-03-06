//
//  TableViewTextCell.swift
//  Example
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewTextCell: TableViewCell {

    @IBOutlet weak var labelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    override func cellDidLoad() {
        super.cellDidLoad()
        self.textField.inputAccessoryView = self.actionBar
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        // Fix label center Y
        //
        self.labelCenterYConstraint.constant = 0.5
    }
    
    override func responder() -> UIResponder? {
        return self.textField
    }
    
}
