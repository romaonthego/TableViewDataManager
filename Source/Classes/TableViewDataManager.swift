//
// TableViewDataManager.swift
// TableViewDataManager
//
// Copyright (c) 2016 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

public class TableViewDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Public variables
    //
    public var dataSource: TableViewDataSource?
    public var style: TableViewCellStyle?
    public var showsIndexList = false
    public var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }

    // MARK: Instance Lifecycle
    //
    public init(tableView: UITableView, dataSource: TableViewDataSource) {
        super.init();
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.dataSource = dataSource
        self.registerCellClass(TableViewCell.self, forItemClass: TableViewItem.self)
        [ "TableViewCell": TableViewItem.self,
          "TableViewTextFieldCell": TableViewTextFieldItem.self,
          "TableViewSwitchCell": TableViewSwitchItem.self,
          "TableViewSliderCell": TableViewSliderItem.self,
          "TableViewDateTimeCell": TableViewDateTimeItem.self,
          "TableViewDatePickerCell": TableViewDatePickerItem.self,
          "TableViewPickerCell": TableViewPickerItem.self,
          "TableViewPickerViewCell": TableViewPickerViewItem.self,
          "TableViewTextViewCell": TableViewTextViewItem.self,
          "TableViewSegmentedControlCell": TableViewSegmentedControlItem.self ].forEach { self.registerNib(UINib(nibName: $0, bundle: NSBundle(forClass: TableViewDataManager.self)), forItemClass: $1) }
    }
    
    deinit {
        self.tableView?.delegate = nil
        self.tableView?.dataSource = nil
    }
    
    public convenience init(tableView: UITableView) {
        self.init(tableView: tableView, dataSource: TableViewDataSource())
    }
    
    // MARK: Public methods
    //
    public func registerCellClass(cellClass: AnyClass, forItemClass itemClass: AnyClass) {
        self.tableView?.registerClass(cellClass, forCellReuseIdentifier: NSStringFromClass(itemClass))
    }
    
    public func registerNib(nib: UINib, forItemClass: AnyClass) {
        let identifier = NSStringFromClass(forItemClass)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
    }
    
    public func indexPathForPreviousResponderInSectionIndex(sectionIndex: Int, currentSection: TableViewSection, currentItem: TableViewItem) -> NSIndexPath? {
        guard let _ = self.dataSource, let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: sectionIndex)) else {
            return nil
        }
        let items = section.items as NSArray
        let indexInSection = section === currentSection ? items.indexOfObject(currentItem) : section.items.count
        for itemIndex in (0..<indexInSection).reverse() {
            let item = section.items[itemIndex]
            if item is TableViewItemFocusable {
                return NSIndexPath(forRow: itemIndex, inSection: sectionIndex)
            }
        }
        return nil
    }
    
    public func indexPathForNextResponderInSectionIndex(sectionIndex: Int, currentSection: TableViewSection, currentItem: TableViewItem) -> NSIndexPath? {
        guard let _ = self.dataSource, let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: sectionIndex)) else {
            return nil
        }
        let items = section.items as NSArray
        let indexInSection = section === currentSection ? items.indexOfObject(currentItem) : -1
        for itemIndex in (indexInSection+1)..<section.items.count {
            let item = section.items[itemIndex]
            if item is TableViewItemFocusable {
                return NSIndexPath(forRow: itemIndex, inSection: sectionIndex)
            }
        }
        return nil
    }
    
    // MARK: Private methods
    //
    private func sectionAtIndexPath(indexPath: NSIndexPath) -> TableViewSection? {
        guard let dataSource = self.dataSource where indexPath.section < dataSource.sections.count else {
            return nil
        }
        return dataSource.sections[indexPath.section]
    }
    
    private func itemAtIndexPath(indexPath: NSIndexPath) -> TableViewItem? {
        guard let section = self.sectionAtIndexPath(indexPath) where indexPath.row < section.items.count else {
            return nil
        }
        return section.items[indexPath.row]
    }
    
    // MARK: <UITableViewDataSource> methods
    //
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = self.dataSource {
            if section < dataSource.sections.count {
                return dataSource.sections[section].items.count
            }
        }
        return 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath) else {
            return TableViewCell()
        }
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
        cell.tableViewDataManager = self
        if !cell.cellLoaded {
            cell.cellDidLoad()
            cell.cellLoaded = true
        }
        cell.cellWillAppear()
        
        if let configurationHandler = section.configurationHandler {
            configurationHandler(tableViewCell: cell)
        }
        
        if let configurationHandler = item.configurationHandler {
            configurationHandler(tableViewCell: cell)
        }
        
        return cell
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let dataSource = self.dataSource else {
            return 0
        }
        return dataSource.sections.count
    }
    
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)) else {
            return nil
        }
        return section.headerTitle
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section)) else {
            return nil
        }
        return section.footerTitle
    }
    
    // Editing
    
    // Individual rows can opt out of having the -editing property set for them.
    //
    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return false
        }
        return item.editingStyle != .None || item.moveHandler != nil
    }
    
    // Moving/reordering
    
    // Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
    //
    public func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return false
        }
        return item.moveHandler != nil
    }
    
    // Index
    
    public func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        if !self.showsIndexList {
            return nil
        }
        var indexTitles: [String] = []
        guard let dataSource = self.dataSource else {
            return indexTitles
        }
        for section in dataSource.sections {
            if let indexTitle = section.indexTitle {
                indexTitles.append(indexTitle)
            } else {
                indexTitles.append("")
            }
        }
        return indexTitles
    }
    
    // Data manipulation - insert and delete support
    
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    //
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath) else {
            return
        }
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
    
    // Data manipulation - reorder / moving support
    
    public func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        guard let sourceSection = self.sectionAtIndexPath(sourceIndexPath), let item = self.itemAtIndexPath(sourceIndexPath), let destinationSection = self.sectionAtIndexPath(destinationIndexPath) else {
            return
        }
        sourceSection.items.removeAtIndex(sourceIndexPath.row)
        destinationSection.items.insert(item, atIndex: destinationIndexPath.row)
        
        if let moveCompletionHandler = item.moveCompletionHandler {
            moveCompletionHandler(section: destinationSection, item: item, tableView: tableView, sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
        }
    }

    // MARK: <UITableViewDelegate> methods
    //
    
    // Display customization
    
    public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let displayHandler = item.displayHandler else {
            return
        }
        displayHandler(section: section, item: item, tableView: tableView, indexPath: indexPath, tableViewCell: cell as! TableViewCell, status: .WillDisplay)
    }
    
    
    public func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection index: Int) {
        let indexPath = NSIndexPath(forRow: 0, inSection: index)
        guard let section = self.sectionAtIndexPath(indexPath), let headerDisplayHandler = section.headerDisplayHandler else {
            return
        }
        headerDisplayHandler(section: section, tableView: tableView, indexPath: indexPath, view: view, status: .WillDisplay)
    }
    
    public func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection index: Int) {
        let indexPath = NSIndexPath(forRow: 0, inSection: index)
        guard let section = self.sectionAtIndexPath(indexPath), let footerDisplayHandler = section.footerDisplayHandler else {
            return
        }
        footerDisplayHandler(section: section, tableView: tableView, indexPath: indexPath, view: view, status: .WillDisplay)
    }
    
    public func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let displayHandler = item.displayHandler else {
            return
        }
        displayHandler(section: section, item: item, tableView: tableView, indexPath: indexPath, tableViewCell: cell as! TableViewCell, status: .DidEndDisplaying)
    }
    
    public func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection index: Int) {
        let indexPath = NSIndexPath(forRow: 0, inSection: index)
        guard let section = self.sectionAtIndexPath(indexPath), let footerDisplayHandler = section.footerDisplayHandler else {
            return
        }
        footerDisplayHandler(section: section, tableView: tableView, indexPath: indexPath, view: view, status: .DidEndDisplaying)
    }
    
    public func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection index: Int) {
        let indexPath = NSIndexPath(forRow: 0, inSection: index)
        guard let section = self.sectionAtIndexPath(indexPath), let footerDisplayHandler = section.footerDisplayHandler else {
            return
        }
        footerDisplayHandler(section: section, tableView: tableView, indexPath: indexPath, view: view, status: .DidEndDisplaying)
    }
    
    // Variable height support
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return UITableViewAutomaticDimension
        }
        return CGFloat(TableViewCell.heightWithItem(item, tableView: tableView, indexPath: indexPath))
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection index: Int) -> CGFloat {
        guard let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: index)), let headerView = section.headerView else {
            return UITableViewAutomaticDimension
        }
        return headerView.frame.height
    }
    
    public func tableView(tableView: UITableView, heightForFooterInSection index: Int) -> CGFloat {
        guard let section = self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: index)), let footerView = section.footerView else {
            return UITableViewAutomaticDimension
        }
        return footerView.frame.height
    }
    
    // Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
    // If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
    //
    public func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return UITableViewAutomaticDimension
        }
        return CGFloat(TableViewCell.estimatedHeightWithItem(item, tableView: tableView, indexPath: indexPath))
    }
    
    // Section header & footer information. Views are preferred over title should you decide to provide both
    //
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section))?.headerView
    }
    
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.sectionAtIndexPath(NSIndexPath(forRow: 0, inSection: section))?.footerView
    }
    
    // Accessories (disclosures).
    
    public func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        guard let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), accessoryButtonTapHandler = item.accessoryButtonTapHandler else {
           return
        }
        accessoryButtonTapHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
    }
    
    // Selection
    
    // -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
    // Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
    //
    public func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return true
        }
        return item.selectable
    }
    
    // Called after the user changes the selection.
    //
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let selectionHandler = item.selectionHandler {
            selectionHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
        }
    }
    
    public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        guard let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let deselectionHandler = item.deselectionHandler else {
            return
        }
        deselectionHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
    }
    
    // Editing
    
    // Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
    //
    public func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return .None
        }
        return item.editingStyle
    }
    
    /*
    optional func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
    */
    
    // Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
    //
    public func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return true
        }
        return item.shouldIndentWhileEditing
    }
    
    // The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
    //
    public func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        guard let section = self.sectionAtIndexPath(indexPath), let item = self.itemAtIndexPath(indexPath), let editingHandler = item.editingHandler else {
            return
        }
        editingHandler(section: section, item: item, tableView: tableView, indexPath: indexPath, status: .WillBeginEditing)
    }
    
    public func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath?) {
        guard let section = self.sectionAtIndexPath(indexPath!), let item = self.itemAtIndexPath(indexPath!), let editingHandler = item.editingHandler else {
            return
        }
        return editingHandler(section: section, item: item, tableView: tableView, indexPath: indexPath!, status: .DidEndEditing)
    }

    // Moving/reordering
    
    // Allows customization of the target row for a particular row as it is being moved/reordered
    //
    public func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        guard let sourceSection = self.sectionAtIndexPath(sourceIndexPath), let item = self.itemAtIndexPath(sourceIndexPath), let moveHandler = item.moveHandler else {
            return proposedDestinationIndexPath
        }
        return moveHandler(section: sourceSection, item: item, tableView: tableView, sourceIndexPath: sourceIndexPath, destinationIndexPath: proposedDestinationIndexPath) ? proposedDestinationIndexPath : sourceIndexPath
    }
    
    // Indentation

    public func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return 0
        }
        return item.indentationLevel
    }
    
    // Cut / Copy / Paste.  All three methods must be implemented by the delegate.
    
    public func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return false
        }
        return item.copyHandler != nil || item.pasteHandler != nil || item.cutHandler != nil
    }
    
    public func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        guard let item = self.itemAtIndexPath(indexPath) else {
            return false
        }
        return (item.copyHandler != nil && action == #selector(UIResponderStandardEditActions.copy(_:))) || (item.pasteHandler != nil && action == #selector(UIResponderStandardEditActions.paste(_:))) || (item.cutHandler != nil && action == #selector(UIResponderStandardEditActions.cut(_:)))
    }
    
    public func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        guard let item = self.itemAtIndexPath(indexPath), let section = self.sectionAtIndexPath(indexPath) else {
            return
        }
        if let copyHandler = item.copyHandler where action == #selector(UIResponderStandardEditActions.copy(_:)) {
            copyHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
        }
        if let pasteHandler = item.pasteHandler where action == #selector(UIResponderStandardEditActions.paste(_:)) {
            pasteHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
        }
        if let cutHandler = item.cutHandler where action == #selector(UIResponderStandardEditActions.cut(_:)) {
            cutHandler(section: section, item: item, tableView: tableView, indexPath: indexPath)
        }
    }
}
