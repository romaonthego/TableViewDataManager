//
//  IBTableViewCell.swift
//  Example
//
//  Created by Roman Efimov on 3/4/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit
import TableViewManager

class IBTableViewCell: TableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func cellWillAppear() {
        label.text = self.item.text
    }
    
}
