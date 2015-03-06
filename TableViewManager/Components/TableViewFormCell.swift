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
    @IBOutlet weak var titleLabel: UILabel!
    
    override func updateConstraints() {
        super.updateConstraints()
        
        // Fix label center Y
        //
        self.labelCenterYConstraint.constant = 0.5
    }

}
