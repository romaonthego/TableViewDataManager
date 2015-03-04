//
//  TableViewCell.swift
//  Example
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: Public variables
    //
    var item: TableViewItem!
    var section: TableViewSection!
    var indexPath: NSIndexPath?
    var cellLoaded = false
    var style: TableViewCellStyle?

    // MARK: Cell view lifecycle
    //
    func cellDidLoad() {
        if (self.style?.hasCustomBackgroundImage() != nil || self.style?.hasCustomBackgroundColor() != nil) {
            self.addBackgroundImage()
        }
        
        if (self.style?.hasCustomSelectedBackgroundImage() != nil || self.style?.hasCustomSelectedBackgroundImage() != nil) {
            self.addSelectedBackgroundImage()
        }
    }
    
    func cellWillAppear() {
        self.textLabel?.text = item.text
    }
    
    // MARK: Determining cell height
    //
    static func heightWithItem(item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> Float {
        return item.height
    }
    
    static func estimatedHeightWithItem(item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> Float {
        return heightWithItem(item, tableView: tableView, indexPath: indexPath)
    }
    
    // MARK: Private methods
    //
    private func addBackgroundImage() {
        
    }
    
    private func addSelectedBackgroundImage() {
        
    }
}
