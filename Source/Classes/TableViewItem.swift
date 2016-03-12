//
//  TableViewItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public typealias TableViewItemEditingStyle = UITableViewCellEditingStyle

public enum TableViewEditingStatus {
    case WillBeginEditing
    case DidEndEditing
}

public enum TableViewCellDisplayStatus {
    case WillDisplay
    case DidEndDisplaying
}

public enum TableViewActionBarButton {
    case Previous
    case Next
    case Done
}

public protocol TableViewItemFocusable {
    
}

public class TableViewItem: NSObject, UIAccessibilityIdentification {
    
    // MARK: Variables
    //
    public var text: String?
    public var detailText: String?
    public var section: TableViewSection?
    public var image: UIImage?
    public var highlightedImage: UIImage?
    public var editingStyle: TableViewItemEditingStyle = .None
    public var height: Float = Float(UITableViewAutomaticDimension)
    public var accessibilityIdentifier: String?
    public var indentationLevel: Int = 0
    public var selectable = true
    public var shouldIndentWhileEditing = true
    public var configurationHandler: ((tableViewCell: TableViewCell) -> (Void))?
    public var displayHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, tableViewCell: TableViewCell, status: TableViewCellDisplayStatus) -> (Void))?
    public var selectionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var deselectionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var accessoryButtonTapHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var insertionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var deletionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var deletionHandlerWithCompletion: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, completionHandler: ((Void) -> (Void))) -> (Void))?
    public var moveHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> (Bool))?
    public var moveCompletionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> (Void))?
    public var cutHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var copyHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var pasteHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    public var editingHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, status: TableViewEditingStatus) -> (Void))?
    public var actionBarButtonTapHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, button: TableViewActionBarButton) -> (Void))?
    
    // MARK: Lifecycle
    //
    public convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    public convenience init(text: String?, configurationHandler: (tableViewCell: TableViewCell) -> (Void)) {
        self.init(text: text)
        self.configurationHandler = configurationHandler
    }
    
    public convenience init(text: String?, selectionHandler: (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.selectionHandler = selectionHandler
    }
    
    public convenience init(text: String?, configurationHandler: (tableViewCell: TableViewCell) -> (Void), selectionHandler: (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.configurationHandler = configurationHandler
        self.selectionHandler = selectionHandler
    }
    
    public convenience init(text: String?, image: UIImage) {
        self.init(text: text)
        self.image = image
    }
    
    public convenience init(text: String?, image: UIImage, configurationHandler: (tableViewCell: TableViewCell) -> (Void)) {
        self.init(text: text)
        self.image = image
        self.configurationHandler = configurationHandler
    }
    
    public convenience init(text: String?, image: UIImage, selectionHandler: (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.selectionHandler = selectionHandler
        self.image = image
    }
    
    public convenience init(text: String?, image: UIImage, configurationHandler: (tableViewCell: TableViewCell) -> (Void), selectionHandler: (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.image = image
        self.configurationHandler = configurationHandler
        self.selectionHandler = selectionHandler
    }
    
}