//
//  TableViewCell.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var item: TableViewItem!
    
    func cellWillAppear() {
        self.textLabel?.text = item.text
    }
}
