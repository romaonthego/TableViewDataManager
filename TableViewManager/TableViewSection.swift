//
//  TableViewSection.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

enum TableViewSectionDisplayStatus {
    case WillDisplay
    case DidEndDisplaying
}

class TableViewSection {
    
    // MARK: Variables
    //
    var items: [TableViewItem] = []
    var headerTitle: String?
    var footerTitle: String?
    var headerView: UIView?
    var footerView: UIView?
    var style: TableViewCellStyle?
    var indexTitle: String?
    var configurationHandler: ((tableViewCell: TableViewCell) -> (Void))?
    var headerDisplayHandler: ((section: TableViewSection, tableView: UITableView, indexPath: NSIndexPath, view: UIView, status: TableViewSectionDisplayStatus) -> (Void))?
    var footerDisplayHandler: ((section: TableViewSection, tableView: UITableView, indexPath: NSIndexPath, view: UIView, status: TableViewSectionDisplayStatus) -> (Void))?

    // MARK: Lifecycle
    //    
    convenience init(headerTitle: String) {
        self.init()
        self.headerTitle = headerTitle
    }
    
    convenience init(headerTitle: String, footerTitle: String) {
        self.init(headerTitle: headerTitle)
        self.footerTitle = footerTitle
    }
    
    convenience init(headerView: UIView) {
        self.init()
        self.headerView = headerView
    }
    
    convenience init(headerView: UIView, footerView: UIView) {
        self.init(headerView: headerView)
        self.footerView = footerView
    }
    
}