//
//  TableViewDateCell.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewDateTimeCell: TableViewFormCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let detailTextLabel = self.detailTextLabel else {
            return
        }
        
        detailTextLabel.text = "123"
    }
}
