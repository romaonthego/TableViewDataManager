//
//  TableViewCellStyle.swift
//  Example
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
    
    func hasCustomBackgroundImage() -> Bool {
        return false
    }
    
    func hasCustomBackgroundColor() -> Bool {
        return false
    }
    
    func backgroundImageForCellType(cellType: TableViewCellType) -> UIImage? {
        return nil
    }
    
    func backgroundColorForCellType(cellType: TableViewCellType) -> UIImage? {
        return nil
    }
    
    func setBackgroundImage(image: UIImage, forCellType cellType: TableViewCellType) {
        
    }
    
    func setBackgroundColor(color: UIColor, forCellType cellType: TableViewCellType) {
        
    }
    
    func hasCustomSelectedBackgroundImage() -> Bool {
        return false
    }
    
    func hasCustomSelectedBackgroundColor() -> Bool {
        return false
    }
    
    func selectedBackgroundImageForCellType(cellType: TableViewCellType) -> UIImage? {
        return nil
    }
    
    func selectedBackgroundColorForCellType(cellType: TableViewCellType) -> UIImage? {
        return nil
    }
    
    func setSelectedBackgroundImage(image: UIImage, forCellType cellType: TableViewCellType) {
        
    }
    
    func setSelectedBackgroundColor(color: UIColor, forCellType cellType: TableViewCellType) {
        
    }
}
