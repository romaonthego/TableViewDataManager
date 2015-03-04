//
//  TableViewItem.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

enum TableViewItemEditingStyle {
    case None
    case Delete
    case Insert
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
    var configurationHandler: ((tableViewCell: TableViewCell) -> (Void))?
    var selectionHandler: ((tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void))?
    var insertionHandler: ((tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void))?
    var deletionHandler: ((tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void))?
    var deletionHandlerWithCompletion: ((tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath, (Void) -> (Void)) -> (Void))?
    var moveHandler: ((tableView: UITableView, item: TableViewItem, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> (Bool))?
    var moveCompletionHandler: ((tableView: UITableView, item: TableViewItem, sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) -> (Void))?
    var cutHandler: ((tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void))?
    var copyHandler: ((tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void))?
    var pasteHandler: ((tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void))?
    
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
    
    convenience init(text: String, selectionHandler: (tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.selectionHandler = selectionHandler
    }
    
    convenience init(text: String, configurationHandler: (tableViewCell: TableViewCell) -> (Void), selectionHandler: (tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void)) {
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
    
    convenience init(text: String, image: UIImage, selectionHandler: (tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.selectionHandler = selectionHandler
        self.image = image
    }
    
    convenience init(text: String, image: UIImage, configurationHandler: (tableViewCell: TableViewCell) -> (Void), selectionHandler: (tableView: UITableView, item: TableViewItem, indexPath: NSIndexPath) -> (Void)) {
        self.init(text: text)
        self.image = image
        self.configurationHandler = configurationHandler
        self.selectionHandler = selectionHandler
    }
    
}