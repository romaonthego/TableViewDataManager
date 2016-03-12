//
//  TableViewSection.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public enum TableViewSectionDisplayStatus {
    case WillDisplay
    case DidEndDisplaying
}

public class TableViewSection {
    
    // MARK: Variables
    //
    public var items: [TableViewItem] = []
    public var headerTitle: String?
    public var footerTitle: String?
    public var headerView: UIView?
    public var footerView: UIView?
    public var style: TableViewCellStyle?
    public var indexTitle: String?
    public var configurationHandler: ((tableViewCell: TableViewCell) -> (Void))?
    public var headerDisplayHandler: ((section: TableViewSection, tableView: UITableView, indexPath: NSIndexPath, view: UIView, status: TableViewSectionDisplayStatus) -> (Void))?
    public var footerDisplayHandler: ((section: TableViewSection, tableView: UITableView, indexPath: NSIndexPath, view: UIView, status: TableViewSectionDisplayStatus) -> (Void))?
    
    // MARK: Lifecycle
    //    
    public init() {
        
    }
    
    public convenience init(headerTitle: String) {
        self.init()
        self.headerTitle = headerTitle
    }
    
    public convenience init(headerTitle: String, footerTitle: String) {
        self.init(headerTitle: headerTitle)
        self.footerTitle = footerTitle
    }
    
    public convenience init(headerView: UIView) {
        self.init()
        self.headerView = headerView
    }
    
    public convenience init(headerView: UIView, footerView: UIView) {
        self.init(headerView: headerView)
        self.footerView = footerView
    }
    
}