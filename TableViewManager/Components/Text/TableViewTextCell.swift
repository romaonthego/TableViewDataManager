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
    
    override class func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        self.labelCenterYConstraint.constant = 0.5
    }
    
}
