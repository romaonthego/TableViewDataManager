//
// TableViewItem.swift
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