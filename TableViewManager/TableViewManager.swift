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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if let dataSource = self.dataSource {
            if indexPath.section < dataSource.sections.count {
                let section = self.sectionAtIndexPath(indexPath)
                if (indexPath.row < section.items.count) {
                    let item = self.itemAtIndexPath(indexPath)
                    return item.editingStyle != .None || item.moveHandler != nil
                }
            }
        }
        return false
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.itemAtIndexPath(indexPath).moveHandler != nil
    }
    
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let section = self.sectionAtIndexPath(indexPath)
            let item = self.itemAtIndexPath(indexPath)
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
            let section = self.sectionAtIndexPath(indexPath)
            let item = self.itemAtIndexPath(indexPath)
            if let insertionHandler = item.insertionHandler {
                insertionHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
            }
        }
    }
    
    // Data manipulation - reorder / moving support
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let sourceSection = self.sectionAtIndexPath(sourceIndexPath)
        let item = self.itemAtIndexPath(sourceIndexPath)
        sourceSection.items.removeAtIndex(sourceIndexPath.row)
        
        let destinationSection = self.sectionAtIndexPath(destinationIndexPath)
        destinationSection.items.insert(item, atIndex: destinationIndexPath.row)
        
        if let moveCompletionHandler = item.moveCompletionHandler {
            moveCompletionHandler(section: destinationSection, item: item, tableView: tableView, sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
        }
    }

    
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
    */
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return self.itemAtIndexPath(indexPath).editingStyle
    }
    
    
    /*@availability(iOS, introduced=3.0)
    optional func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String!
    @availability(iOS, introduced=8.0)
    optional func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
    
    // Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
    optional func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool
    
    // The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
    optional func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath)
    optional func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath)
    */

    func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        let sourceSection = self.sectionAtIndexPath(sourceIndexPath)
        let item = self.itemAtIndexPath(sourceIndexPath)
        if let moveHandler = item.moveHandler {
            let allowed = moveHandler(section: sourceSection, item: item, tableView: tableView, sourceIndexPath: sourceIndexPath, destinationIndexPath: proposedDestinationIndexPath)
            if !allowed {
                return sourceIndexPath
            }
        }
        
        return proposedDestinationIndexPath
    }

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