//
//  TableViewCellStyle.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/4/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

enum TableViewCellType {
    case First
    case Middle
    case Last
    case Single
    case Any
}

class TableViewCellStyle {
    
    private var backgroundImages: [TableViewCellType:UIImage] = [:]
    private var selectedBackgroundImages: [TableViewCellType:UIImage] = [:]
    private var backgroundColors: [TableViewCellType:UIColor] = [:]
    private var selectedBackgroundColors: [TableViewCellType:UIColor] = [:]
    
    func hasCustomBackgroundImage() -> Bool {
        return self.backgroundImageForCellType(.Any) != nil || self.backgroundImageForCellType(.First) != nil || self.backgroundImageForCellType(.Middle) != nil || self.backgroundImageForCellType(.Last) != nil || self.backgroundImageForCellType(.Single) != nil
    }
    
    func hasCustomBackgroundColor() -> Bool {
        return self.backgroundColorForCellType(.Any) != nil || self.backgroundColorForCellType(.First) != nil || self.backgroundColorForCellType(.Middle) != nil || self.backgroundColorForCellType(.Last) != nil || self.backgroundColorForCellType(.Single) != nil
    }
    
    func backgroundImageForCellType(cellType: TableViewCellType) -> UIImage? {
        let image = self.backgroundImages[cellType]
        if image == nil && cellType != .Any {
            return self.backgroundImages[.Any]
        }
        return image
    }
    
    func backgroundColorForCellType(cellType: TableViewCellType) -> UIColor? {
        let backgroundColor = self.backgroundColors[cellType]
        if backgroundColor == nil && cellType != .Any {
            return self.backgroundColors[.Any]
        }
        return backgroundColor
    }
    
    func setBackgroundImage(image: UIImage, forCellType cellType: TableViewCellType) {
        self.backgroundImages[cellType] = image
    }
    
    func setBackgroundColor(color: UIColor, forCellType cellType: TableViewCellType) {
        self.backgroundColors[cellType] = color
    }
    
    func hasCustomSelectedBackgroundImage() -> Bool {
        return self.selectedBackgroundImageForCellType(.Any) != nil || self.selectedBackgroundImageForCellType(.First) != nil || self.selectedBackgroundImageForCellType(.Middle) != nil || self.selectedBackgroundImageForCellType(.Last) != nil || self.selectedBackgroundImageForCellType(.Single) != nil
    }
    
    func hasCustomSelectedBackgroundColor() -> Bool {
        return self.selectedBackgroundColorForCellType(.Any) != nil || self.selectedBackgroundColorForCellType(.First) != nil || self.selectedBackgroundColorForCellType(.Middle) != nil || self.selectedBackgroundColorForCellType(.Last) != nil || self.selectedBackgroundColorForCellType(.Single) != nil
    }
    
    func selectedBackgroundImageForCellType(cellType: TableViewCellType) -> UIImage? {
        let image = self.selectedBackgroundImages[cellType]
        if image == nil && cellType != .Any {
            return self.selectedBackgroundImages[.Any]
        }
        return image
    }
    
    func selectedBackgroundColorForCellType(cellType: TableViewCellType) -> UIColor? {
        let backgroundColor = self.selectedBackgroundColors[cellType]
        if backgroundColor == nil && cellType != .Any {
            return self.selectedBackgroundColors[.Any]
        }
        return backgroundColor
    }
    
    func setSelectedBackgroundImage(image: UIImage, forCellType cellType: TableViewCellType) {
        self.selectedBackgroundImages[cellType] = image
    }
    
    func setSelectedBackgroundColor(color: UIColor, forCellType cellType: TableViewCellType) {
        self.selectedBackgroundColors[cellType] = color
    }
}
