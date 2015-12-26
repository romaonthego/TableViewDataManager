//
//  TableViewCell.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/3/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

let kYTMTableViewCellPadding: Float = 15

class TableViewCell: UITableViewCell {
    
    // MARK: Public variables
    //
    var item: TableViewItem!
    var section: TableViewSection!
    var indexPath: NSIndexPath?
    var cellLoaded = false
    var style: TableViewCellStyle?
    var backgroundImageView: UIImageView?
    var selectedBackgroundImageView: UIImageView?
    var actionBar: TableViewActionBar?
    var tableViewManager: TableViewManager!
    var type: TableViewCellType {
        get {
            guard let indexPath = self.indexPath, section = self.section else {
                return .Any
            }
            switch (indexPath.row, section.items.count) {
            case let (row, count) where row == 0 && count == 1:
                return .Single
            case let (row, count) where row == 0 && count > 1:
                return .First
            case let (row, count) where row > 0 && row < count - 1 && count > 2:
                return .Middle
            case let (row, count) where row == count - 1 && count > 1:
                return .Last
            default:
                return .Any
            }
        }
    }

    // MARK: Cell view lifecycle
    //
    func cellDidLoad() {
        if (self.style?.hasCustomBackgroundImage() != nil || self.style?.hasCustomBackgroundColor() != nil) {
            self.addBackgroundImage()
        }
        
        if (self.style?.hasCustomSelectedBackgroundImage() != nil || self.style?.hasCustomSelectedBackgroundImage() != nil) {
            self.addSelectedBackgroundImage()
        }
        
        self.actionBar = TableViewActionBar(navigationHandler: { [weak self] (index: Int) -> (Void) in
            if let strongSelf = self, let tableView = strongSelf.tableViewManager.tableView, let indexPath = strongSelf.indexPath {
                if let indexPath = index == 0 ? strongSelf.indexPathForPreviousResponder() : strongSelf.indexPathForNextResponder() {
                    var cell = tableView.cellForRowAtIndexPath(indexPath) as? TableViewCell
                    if cell == nil {
                        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                    }
                    cell = tableView.cellForRowAtIndexPath(indexPath) as? TableViewCell
                    if let cell = cell, let responder = cell.responder() {
                        responder.becomeFirstResponder()
                    }
                }
                
                if let actionBarButtonTapHandler = strongSelf.item.actionBarButtonTapHandler {
                    actionBarButtonTapHandler(section: strongSelf.section, item: strongSelf.item, tableView: tableView, indexPath: indexPath, button: index == 0 ? .Previous : .Next)
                }
            }
        }, doneHandler: { [weak self] in
            if let strongSelf = self, let tableView = strongSelf.tableViewManager.tableView, let indexPath = strongSelf.indexPath {
                strongSelf.endEditing(true)
                if let actionBarButtonTapHandler = strongSelf.item.actionBarButtonTapHandler {
                    actionBarButtonTapHandler(section: strongSelf.section, item: strongSelf.item, tableView: tableView, indexPath: indexPath, button: .Done)
                }
            }
        })
    }
    
    func cellWillAppear() {
        updateActionBarNavigationControl()
        self.textLabel?.text = item.text
        self.detailTextLabel?.text = item.detailText
        self.imageView?.image = self.item.image
        self.imageView?.highlightedImage = self.item.highlightedImage
    }
    
    // MARK: Public methods
    //
    class func heightWithItem(item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> Float {
        return item.height
    }
    
    class func estimatedHeightWithItem(item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> Float {
        return heightWithItem(item, tableView: tableView, indexPath: indexPath)
    }
    
    func updateActionBarNavigationControl() {
        if let actionBar = self.actionBar {
            actionBar.navigationControl.setEnabled(self.indexPathForPreviousResponder() != nil, forSegmentAtIndex: 0)
            actionBar.navigationControl.setEnabled(self.indexPathForNextResponder() != nil, forSegmentAtIndex: 1)
        }
    }
    
    func responder() -> UIResponder? {
        return nil
    }
    
    func indexPathForPreviousResponder() -> NSIndexPath? {
        if let indexPath = self.indexPath {
            for (var itemIndex = indexPath.section; itemIndex >= 0; itemIndex--) {
                if let indexPath = self.tableViewManager.indexPathForPreviousResponderInSectionIndex(itemIndex, currentSection: self.section, currentItem: self.item) {
                    return indexPath;
                }
            }
        }
        return nil
    }
    
    func indexPathForNextResponder() -> NSIndexPath? {
        if let indexPath = self.indexPath, let datasource = self.tableViewManager.dataSource {
            for var itemIndex = indexPath.section; itemIndex < datasource.sections.count; itemIndex++ {
                if let indexPath = self.tableViewManager.indexPathForNextResponderInSectionIndex(itemIndex, currentSection: self.section, currentItem: self.item) {
                    return indexPath;
                }
            }
        }
        return nil
    }

    // MARK: Overrides
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = self.imageView, _ = imageView.image {
            imageView.frame.origin.x = self.separatorInset.left
            if let textLabel = self.textLabel {
                textLabel.frame.origin.x = CGRectGetMaxX(imageView.frame) + self.indentationWidth
                textLabel.frame.size.width = CGRectGetWidth(self.contentView.frame) - textLabel.frame.origin.x - CGFloat(kYTMTableViewCellPadding)
            }
        }
        
        guard let style = self.style else {
            return
        }
        
        if style.hasCustomBackgroundColor() || style.hasCustomBackgroundImage() {
            self.backgroundColor = UIColor.clearColor()
            if self.backgroundImageView == nil {
                self.addBackgroundImage()
            }
        }
        
        if style.hasCustomSelectedBackgroundColor() || style.hasCustomSelectedBackgroundImage() {
            if self.selectedBackgroundImageView == nil {
                self.addSelectedBackgroundImage()
            }
        }
        
        if let backgroundImageView = self.backgroundImageView where style.hasCustomBackgroundColor()  {
            backgroundImageView.backgroundColor = style.backgroundColorForCellType(self.type)
        }
        if let backgroundImageView = self.backgroundImageView where style.hasCustomBackgroundImage()  {
            backgroundImageView.image = style.backgroundImageForCellType(self.type)
        }
        if let selectedBackgroundImageView = self.selectedBackgroundImageView where style.hasCustomSelectedBackgroundColor()  {
            selectedBackgroundImageView.backgroundColor = style.selectedBackgroundColorForCellType(self.type)
        }
        if let selectedBackgroundImageView = self.selectedBackgroundImageView where style.hasCustomSelectedBackgroundImage()  {
            selectedBackgroundImageView.image = style.selectedBackgroundImageForCellType(self.type)
        }
    }
    
    // MARK: Private methods
    //
    private func addBackgroundImage() {
        self.backgroundImageView = {
            let view = UIImageView(frame: CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height + 1))
            view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            return view
        }();
        self.backgroundView = {
            let view = UIView(frame: self.contentView.bounds)
            view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            if let backgroundImageView = self.backgroundImageView {
                view.addSubview(backgroundImageView)
            }
            return view
        }();
    }
    
    private func addSelectedBackgroundImage() {
        self.selectedBackgroundImageView = {
            let view = UIImageView(frame: CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height + 1))
            view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            return view
        }();
        self.selectedBackgroundView = {
            let view = UIView(frame: self.contentView.bounds)
            view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            if let selectedBackgroundImageView = self.selectedBackgroundImageView {
                view.addSubview(selectedBackgroundImageView)
            }
            return view
        }();
    }
}