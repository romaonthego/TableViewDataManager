//
//  TableViewItem.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

typealias TableViewItemEditingStyle = UITableViewCellEditingStyle

enum TableViewEditingStatus {
    case WillBeginEditing
    case DidEndEditing
}

enum TableViewCellDisplayStatus {
    case WillDisplay
    case DidEndDisplay
}

class TableViewItem: NSObject, UIAccessibilityIdentification {
    
    // MARK: Variables
    //
    var text: String?
    var detailText: String?
    var section: TableViewSection?
    var image: UIImage?
    var highlightedImage: UIImage?
    var editingStyle: TableViewItemEditingStyle = .None
    var height: Float = 44
    var accessibilityIdentifier: String?
    var indentationLevel: Int = 0
    var selectable = true
    var shouldIndentWhileEditing = true
    var configurationHandler: ((tableViewCell: TableViewCell) -> (Void))?
    var displayHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, tableViewCell: TableViewCell, status: TableViewCellDisplayStatus) -> (Void))?
    var selectionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var deselectionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var accessoryButtonTapHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var insertionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var deletionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var deletionHandlerWithCompletion: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, completionHandler: ((Void) -> (Void))) -> (Void))?
    var moveHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> (Bool))?
    var moveCompletionHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> (Void))?
    var cutHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var copyHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var pasteHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void))?
    var editingHandler: ((section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath, status: TableViewEditingStatus) -> (Void))?
    
    // MARK: Lifecycle
    //
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    convenience init(text: String, configurationHandler: (tableViewCell: TableViewCell) -> (Void)) {
        self.init(text: text)
        self.configurationHandler = configurationHandler
    }
    
    convenience init(text: String, selectionHandler: (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.selectionHandler = selectionHandler
    }
    
    convenience init(text: String, configurationHandler: (tableViewCell: TableViewCell) -> (Void), selectionHandler: (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.configurationHandler = configurationHandler
        self.selectionHandler = selectionHandler
    }
    
    convenience init(text: String, image: UIImage) {
        self.init(text: text)
        self.image = image
    }
    
    convenience init(text: String, image: UIImage, configurationHandler: (tableViewCell: TableViewCell) -> (Void)) {
        self.init(text: text)
        self.image = image
        self.configurationHandler = configurationHandler
    }
    
    convenience init(text: String, image: UIImage, selectionHandler: (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.selectionHandler = selectionHandler
        self.image = image
    }
    
    convenience init(text: String, image: UIImage, configurationHandler: (tableViewCell: TableViewCell) -> (Void), selectionHandler: (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.image = image
        self.configurationHandler = configurationHandler
        self.selectionHandler = selectionHandler
    }
    
}