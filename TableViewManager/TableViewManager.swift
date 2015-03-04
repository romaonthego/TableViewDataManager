//
//  TableViewManager.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables
    //
    var dataSource: TableViewDataSource?
    var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }

    // MARK: Lifecycle
    //
    init(tableView: UITableView, dataSource: TableViewDataSource) {
        super.init();
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.dataSource = dataSource
        self.registerCellClass(TableViewCell.self, forItemClass: TableViewItem.self)
    }
    
    convenience init(tableView: UITableView) {
        self.init(tableView: tableView, dataSource: TableViewDataSource())
    }
    
    // MARK: Public methods
    //
    func registerCellClass(cellClass: AnyClass, forItemClass: AnyClass) {
        let identifier = NSStringFromClass(forItemClass)
        self.tableView?.registerClass(cellClass, forCellReuseIdentifier: NSStringFromClass(forItemClass))
    }
    
    func registerNib(nib: UINib, forItemClass: AnyClass) {
        let identifier = NSStringFromClass(forItemClass)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
    }
    
    // MARK: <UITableViewDataSource> methods
    //
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = self.dataSource {
            return dataSource.sections[section].items.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = self.dataSource?.sections[indexPath.section] as TableViewSection!
        let item = section?.items[indexPath.row] as TableViewItem!
        let identifier = NSStringFromClass(item?.dynamicType)
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! TableViewCell
        
        cell.item = item
        cell.section = section
        cell.indexPath = indexPath
        cell.accessibilityIdentifier = item.accessibilityIdentifier
        cell.cellWillAppear()
        
        if let configurationHandler = section.configurationHandler {
            configurationHandler(tableViewCell: cell)
        }
        
        if let configurationHandler = item.configurationHandler {
            configurationHandler(tableViewCell: cell)
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let dataSource = self.dataSource {
            return dataSource.sections.count
        }
        return 0
    }
    
    /*
    optional func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    optional func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?
    
    // Editing
    
    // Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
    optional func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    
    // Moving/reordering
    
    // Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
    optional func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    
    // Index
    
    optional func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    optional func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int // tell table which section corresponds to section title/index (e.g. "B",1))
    
    // Data manipulation - insert and delete support
    
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    optional func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    
    // Data manipulation - reorder / moving support
    
    optional func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
*/
}