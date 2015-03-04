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
    
    deinit {
        self.tableView?.delegate = nil
        self.tableView?.dataSource = nil
    }
    
    convenience init(tableView: UITableView) {
        self.init(tableView: tableView, dataSource: TableViewDataSource())
    }
    
    // MARK: Public methods
    //
    func registerCellClass(cellClass: AnyClass, forItemClass itemClass: AnyClass) {
        let identifier = NSStringFromClass(itemClass)
        self.tableView?.registerClass(cellClass, forCellReuseIdentifier: NSStringFromClass(itemClass))
    }
    
    func registerNib(nib: UINib, forItemClass: AnyClass) {
        let identifier = NSStringFromClass(forItemClass)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
    }
    
    // MARK: Private methods
    //
    private func sectionAtIndexPath(indexPath: NSIndexPath) -> TableViewSection {
        return self.dataSource?.sections[indexPath.section] as TableViewSection!
    }
    
    private func itemAtIndexPath(indexPath: NSIndexPath) -> TableViewItem {
        let section = self.sectionAtIndexPath(indexPath)
        return section.items[indexPath.row] as TableViewItem!
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
        let section = self.sectionAtIndexPath(indexPath)
        let item = self.itemAtIndexPath(indexPath)
        let identifier = NSStringFromClass(item.dynamicType)
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
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)).headerTitle
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)).footerTitle
    }
    
    /*
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
    
    // MARK: <UITableViewDelegate> methods
    //
    /*
    // Display customization
    
    optional func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    @availability(iOS, introduced=6.0)
    optional func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    @availability(iOS, introduced=6.0)
    optional func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    @availability(iOS, introduced=6.0)
    optional func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    @availability(iOS, introduced=6.0)
    optional func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    @availability(iOS, introduced=6.0)
    optional func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    */
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(TableViewCell.heightWithItem(self.itemAtIndexPath(indexPath), tableView: tableView, indexPath: indexPath))
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let headerView = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)).headerView {
            return headerView.frame.height
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let footerView = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)).footerView {
            return footerView.frame.height
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = self.itemAtIndexPath(indexPath)
        return CGFloat(TableViewCell.estimatedHeightWithItem(item, tableView: tableView, indexPath: indexPath))
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)).headerView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)).footerView
    }
    
    /*
    // Accessories (disclosures).
    
    optional func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath)
    
    // Selection
    
    // -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
    // Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
    @availability(iOS, introduced=6.0)
    optional func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool
    @availability(iOS, introduced=6.0)
    optional func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    @availability(iOS, introduced=6.0)
    optional func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath)
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
    optional func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    @availability(iOS, introduced=3.0)
    optional func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    // Called after the user changes the selection.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.itemAtIndexPath(indexPath)
        let section = self.sectionAtIndexPath(indexPath)
        if let selectionHandler = item.selectionHandler {
            selectionHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
        }
    }
    
    /*
    @availability(iOS, introduced=3.0)
    optional func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    
    // Editing
    
    // Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
    optional func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle
    @availability(iOS, introduced=3.0)
    optional func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String!
    @availability(iOS, introduced=8.0)
    optional func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
    
    // Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
    optional func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool
    
    // The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
    optional func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath)
    optional func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath)
    
    // Moving/reordering
    
    // Allows customization of the target row for a particular row as it is being moved/reordered
    optional func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath
    
    // Indentation
    */
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return self.itemAtIndexPath(indexPath).indentationLevel
    }
    
    /*
    // Copy/Paste.  All three methods must be implemented by the delegate.
    
    @availability(iOS, introduced=5.0)
    optional func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool
    @availability(iOS, introduced=5.0)
    optional func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject) -> Bool
    @availability(iOS, introduced=5.0)
    optional func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!)
    */
}