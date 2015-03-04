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
    private var registeredClasses: [String : AnyClass] = [:]

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
        
        self.registeredClasses[identifier] = cellClass
        self.tableView?.registerClass(cellClass, forCellReuseIdentifier: NSStringFromClass(forItemClass))
        //self.tableView?.registerNib(<#nib: UINib#>, forCellReuseIdentifier: <#String#>)
        //self.registeredClasses[]
    }
    
    // MARK: <UITableViewDelegate> methods
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
}