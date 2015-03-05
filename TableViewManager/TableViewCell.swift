//
//  TableViewCell.swift
//  Example
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
    var type: TableViewCellType {
        get {
            if let indexPath = self.indexPath, section = self.section {
                if indexPath.row == 0 && section.items.count == 1 {
                    return .Single
                }
                if indexPath.row == 0 && section.items.count > 1 {
                    return .First
                }
                if indexPath.row > 0 && indexPath.row < section.items.count - 1 && section.items.count > 2 {
                    return .Middle
                }
                if indexPath.row == section.items.count - 1 && section.items.count > 1 {
                    return .Last
                }
            }
            return .Any
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
    }
    
    func cellWillAppear() {
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
    
    class func canBecomeFirstResponder() -> Bool {
        return false
    }
    
    // MARK: Overrides
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = self.imageView, image = imageView.image {
            imageView.frame.origin.x = self.separatorInset.left
            if let textLabel = self.textLabel {
                textLabel.frame.origin.x = CGRectGetMaxX(imageView.frame) + self.indentationWidth
                textLabel.frame.size.width = CGRectGetWidth(self.contentView.frame) - textLabel.frame.origin.x - CGFloat(kYTMTableViewCellPadding)
            }
        }
        
        if let style = self.style {
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
    }
    
    // MARK: Private methods
    //
    private func addBackgroundImage() {
        self.backgroundImageView = {
            let view = UIImageView(frame: CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height + 1))
            view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            return view
        }();
        self.backgroundView = {
            let view = UIView(frame: self.contentView.bounds)
            view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            if let backgroundImageView = self.backgroundImageView {
                view.addSubview(backgroundImageView)
            }
            return view
        }();
    }
    
    private func addSelectedBackgroundImage() {
        self.selectedBackgroundImageView = {
            let view = UIImageView(frame: CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height + 1))
            view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            return view
        }();
        self.selectedBackgroundView = {
            let view = UIView(frame: self.contentView.bounds)
            view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            if let selectedBackgroundImageView = self.selectedBackgroundImageView {
                view.addSubview(selectedBackgroundImageView)
            }
            return view
        }();
    }
}