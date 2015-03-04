//
//  TableViewSection.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

 class TableViewSection {
    
    // MARK: Variables
    //
    var items: [TableViewItem] = []
    var headerTitle: String?
    var footerTitle: String?
    var headerView: UIView?
    var footerView: UIView?
    var hidden: Bool = false
    var configurationHandler: ((tableViewCell: TableViewCell) -> (Void))?

    init(headerTitle: String) {
        self.headerTitle = headerTitle
    }
    
    convenience init(headerTitle: String, footerTitle: String) {
        self.init(headerTitle: headerTitle)
        self.footerTitle = footerTitle
    }
    
    init(headerView: UIView) {
        self.headerView = headerView
    }
    
    convenience init(headerView: UIView, footerView: UIView) {
        self.init(headerView: headerView)
        self.footerView = footerView
    }
    
}