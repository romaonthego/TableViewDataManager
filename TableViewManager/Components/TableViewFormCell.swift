//
//  TableViewFormCell.swift
//  Example
//
//  Created by Roman Efimov on 3/6/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewFormCell: TableViewCell {

    @IBOutlet weak var labelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelRightMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func cellWillAppear() {
        super.cellWillAppear()
        self.titleLabel.text = self.item.text
        if let text = self.item.text where count(text) > 0 {
            self.labelRightMarginConstraint.constant = 5
        } else {
            self.labelRightMarginConstraint.constant = 0
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        // Fix label center Y
        //
        self.labelCenterYConstraint.constant = 0.5
    }

}
