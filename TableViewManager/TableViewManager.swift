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
    var style: TableViewCellStyle?
    var showsIndexList = false
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
    private func sectionAtIndexPath(indexPath: NSIndexPath) -> TableViewSection? {
        if let dataSource = self.dataSource {
            if indexPath.section < dataSource.sections.count {
                return dataSource.sections[indexPath.section]
            }
        }
        return nil
    }
    
    private func itemAtIndexPath(indexPath: NSIndexPath) -> TableViewItem? {
        if let section = self.sectionAtIndexPath(indexPath) {
            if (indexPath.row < section.items.count) {
                return section.items[indexPath.row]
            }
        }
        return nil
    }
    
    // MARK: <UITableViewDataSource> methods
    //
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = self.dataSource {
            if section < dataSource.sections.count {
                return dataSource.sections[section].items.count
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath) {
            let identifier = NSStringFromClass(item.dynamicType)
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! TableViewCell
            
            cell.style = self.style
            if let sectionStyle = section.style {
                cell.style = sectionStyle
            }
            cell.item = item
            cell.section = section
            cell.indexPath = indexPath
            cell.separatorInset = tableView.separatorInset
            cell.accessibilityIdentifier = item.accessibilityIdentifier
            cell.cellDidLoad()
            cell.cellWillAppear()
            
            if let configurationHandler = section.configurationHandler {
                configurationHandler(tableViewCell: cell)
            }
            
            if let configurationHandler = item.configurationHandler {
                configurationHandler(tableViewCell: cell)
            }
            
            return cell
        }
        return TableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let dataSource = self.dataSource {
            return dataSource.sections.count
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)) {
            return section.headerTitle
        }
        return nil
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)) {
            return section.footerTitle
        }
        return nil
    }
    
    // Editing
    
    // Individual rows can opt out of having the -editing property set for them.
    //
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if let item = self.itemAtIndexPath(indexPath) {
            return item.editingStyle != .None || item.moveHandler != nil
        }
        return false
    }
    
    // Moving/reordering
    
    // Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
    //
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if let item = self.itemAtIndexPath(indexPath) {
            return item.moveHandler != nil
        }
        return false
    }
    
    // Index
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        if !self.showsIndexList {
            return nil
        }
        
        var indexTitles: [String] = []
        if let dataSource = self.dataSource {
            for section in dataSource.sections {
                if let indexTitle = section.indexTitle {
                    indexTitles.append(indexTitle)
                } else {
                    indexTitles.append("")
                }
            }
        }
        return indexTitles
    }
    
    // Data manipulation - insert and delete support
    
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    //
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath) {
            if editingStyle == .Delete {
                if let deletionHandlerWithCompletion = item.deletionHandlerWithCompletion {
                    deletionHandlerWithCompletion(section: section, item: item, tableView: tableView, indexPath: indexPath, completionHandler: { (Void) -> (Void) in
                        section.items.removeAtIndex(indexPath.row)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    })
                } else {
                    if let deletionHandler = item.deletionHandler {
                        deletionHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
                    }
                    section.items.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                }
            }
            
            if editingStyle == .Insert {
                if let insertionHandler = item.insertionHandler {
                    insertionHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
                }
            }
        }
    }
    
    // Data manipulation - reorder / moving support
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if let sourceSection = self.sectionAtIndexPath(sourceIndexPath), let item = self.itemAtIndexPath(sourceIndexPath), let destinationSection = self.sectionAtIndexPath(destinationIndexPath) {
            sourceSection.items.removeAtIndex(sourceIndexPath.row)
            destinationSection.items.insert(item, atIndex: destinationIndexPath.row)
            
            if let moveCompletionHandler = item.moveCompletionHandler {
                moveCompletionHandler(section: destinationSection, item: item, tableView: tableView, sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
            }
        }
    }

    
    // MARK: <UITableViewDelegate> methods
    //
    
    // Display customization
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let displayHandler = item.displayHandler {
            displayHandler(section: section, item: item, tableView: tableView, indexPath: indexPath, tableViewCell: cell as! TableViewCell, status: .WillDisplay)
        }
    }
    
    /*
    optional func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    optional func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    */
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let displayHandler = item.displayHandler {
            displayHandler(section: section, item: item, tableView: tableView, indexPath: indexPath, tableViewCell: cell as! TableViewCell, status: .DidEndDisplay)
        }
    }
    
    /*
    optional func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    optional func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    */
    
    // Variable height support
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let item = self.itemAtIndexPath(indexPath) {
            return CGFloat(TableViewCell.heightWithItem(item, tableView: tableView, indexPath: indexPath))
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection index: Int) -> CGFloat {
        if let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: index)), let headerView = section.headerView {
            return headerView.frame.height
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection index: Int) -> CGFloat {
        if let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: index)), let footerView = section.footerView {
            return footerView.frame.height
        }
        return UITableViewAutomaticDimension
    }
    
    // Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
    // If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
    //
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let item = self.itemAtIndexPath(indexPath) {
            return CGFloat(TableViewCell.estimatedHeightWithItem(item, tableView: tableView, indexPath: indexPath))
        }
        return UITableViewAutomaticDimension
    }
    
    // Section header & footer information. Views are preferred over title should you decide to provide both
    //
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section))?.headerView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section))?.footerView
    }
    
    // Accessories (disclosures).
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), accessoryButtonTapHandler = item.accessoryButtonTapHandler {
            accessoryButtonTapHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
        }
    }
    
    // Selection
    
    // -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
    // Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
    //
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if let item = self.itemAtIndexPath(indexPath) {
            return item.selectable
        }
        return true
    }
    
    /*
    optional func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    optional func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath)
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
    //
    optional func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    optional func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    */
    
    // Called after the user changes the selection.
    //
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let selectionHandler = item.selectionHandler {
            selectionHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let deselectionHandler = item.deselectionHandler {
            deselectionHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
        }
    }
    
    // Editing
    
    // Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
    //
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if let item = self.itemAtIndexPath(indexPath) {
            return item.editingStyle
        }
        return .None
    }
    
    /*
    optional func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
    */
    
    // Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
    //
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if let item = self.itemAtIndexPath(indexPath) {
            return item.shouldIndentWhileEditing
        }
        return true
    }
    
    // The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
    //
    func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let editingHandler = item.editingHandler {
            return editingHandler(section: section, item: item, tableView: tableView, indexPath: indexPath, status: .WillBeginEditing)
        }
    }
    
    func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let editingHandler = item.editingHandler {
            return editingHandler(section: section, item: item, tableView: tableView, indexPath: indexPath, status: .DidEndEditing)
        }
    }

    // Moving/reordering
    
    // Allows customization of the target row for a particular row as it is being moved/reordered
    //
    func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        if let sourceSection = self.sectionAtIndexPath(sourceIndexPath), let item = self.itemAtIndexPath(sourceIndexPath), let moveHandler = item.moveHandler {
            let allowed = moveHandler(section: sourceSection, item: item, tableView: tableView, sourceIndexPath: sourceIndexPath, destinationIndexPath: proposedDestinationIndexPath)
            if !allowed {
                return sourceIndexPath
            }
        }
        return proposedDestinationIndexPath
    }
    
    // Indentation

    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if let item = self.itemAtIndexPath(indexPath) {
            return item.indentationLevel
        }
        return 0
    }
    
    // Cut / Copy / Paste.  All three methods must be implemented by the delegate.
    
    func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if let item = self.itemAtIndexPath(indexPath) {
            return item.copyHandler != nil || item.pasteHandler != nil || item.cutHandler != nil
        }
        return false
    }
    
    func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject) -> Bool {
        if let item = self.itemAtIndexPath(indexPath) {
            if item.copyHandler != nil && action == Selector("copy:") {
                return true
            }
            if item.pasteHandler != nil && action == Selector("paste:") {
                return true
            }
            if item.cutHandler != nil && action == Selector("cut:") {
                return true
            }
        }
        return false
    }
    
    func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) {
        if let item = self.itemAtIndexPath(indexPath), let section = self.sectionAtIndexPath(indexPath) {
            if let copyHandler = item.copyHandler where action == Selector("copy:") {
                copyHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
            }
            if let pasteHandler = item.pasteHandler where action == Selector("paste:") {
                pasteHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
            }
            if let cutHandler = item.cutHandler where action == Selector("cut:") {
                cutHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
            }
        }
    }
}