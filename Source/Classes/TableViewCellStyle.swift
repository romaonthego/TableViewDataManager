//
// TableViewCellStyle.swift
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

public enum TableViewCellType {
    case First
    case Middle
    case Last
    case Single
    case Any
}

public class TableViewCellStyle {
    
    private var backgroundImages: [TableViewCellType:UIImage] = [:]
    private var selectedBackgroundImages: [TableViewCellType:UIImage] = [:]
    private var backgroundColors: [TableViewCellType:UIColor] = [:]
    private var selectedBackgroundColors: [TableViewCellType:UIColor] = [:]
    
    public init() {
    
    }
    
    public func hasCustomBackgroundImage() -> Bool {
        return self.backgroundImageForCellType(.Any) != nil || self.backgroundImageForCellType(.First) != nil || self.backgroundImageForCellType(.Middle) != nil || self.backgroundImageForCellType(.Last) != nil || self.backgroundImageForCellType(.Single) != nil
    }
    
    public func hasCustomBackgroundColor() -> Bool {
        return self.backgroundColorForCellType(.Any) != nil || self.backgroundColorForCellType(.First) != nil || self.backgroundColorForCellType(.Middle) != nil || self.backgroundColorForCellType(.Last) != nil || self.backgroundColorForCellType(.Single) != nil
    }
    
    public func backgroundImageForCellType(cellType: TableViewCellType) -> UIImage? {
        let image = self.backgroundImages[cellType]
        if image == nil && cellType != .Any {
            return self.backgroundImages[.Any]
        }
        return image
    }
    
    public func backgroundColorForCellType(cellType: TableViewCellType) -> UIColor? {
        let backgroundColor = self.backgroundColors[cellType]
        if backgroundColor == nil && cellType != .Any {
            return self.backgroundColors[.Any]
        }
        return backgroundColor
    }
    
    public func setBackgroundImage(image: UIImage, forCellType cellType: TableViewCellType) {
        self.backgroundImages[cellType] = image
    }
    
    public func setBackgroundColor(color: UIColor, forCellType cellType: TableViewCellType) {
        self.backgroundColors[cellType] = color
    }
    
    public func hasCustomSelectedBackgroundImage() -> Bool {
        return self.selectedBackgroundImageForCellType(.Any) != nil || self.selectedBackgroundImageForCellType(.First) != nil || self.selectedBackgroundImageForCellType(.Middle) != nil || self.selectedBackgroundImageForCellType(.Last) != nil || self.selectedBackgroundImageForCellType(.Single) != nil
    }
    
    public func hasCustomSelectedBackgroundColor() -> Bool {
        return self.selectedBackgroundColorForCellType(.Any) != nil || self.selectedBackgroundColorForCellType(.First) != nil || self.selectedBackgroundColorForCellType(.Middle) != nil || self.selectedBackgroundColorForCellType(.Last) != nil || self.selectedBackgroundColorForCellType(.Single) != nil
    }
    
    public func selectedBackgroundImageForCellType(cellType: TableViewCellType) -> UIImage? {
        let image = self.selectedBackgroundImages[cellType]
        if image == nil && cellType != .Any {
            return self.selectedBackgroundImages[.Any]
        }
        return image
    }
    
    public func selectedBackgroundColorForCellType(cellType: TableViewCellType) -> UIColor? {
        let backgroundColor = self.selectedBackgroundColors[cellType]
        if backgroundColor == nil && cellType != .Any {
            return self.selectedBackgroundColors[.Any]
        }
        return backgroundColor
    }
    
    public func setSelectedBackgroundImage(image: UIImage, forCellType cellType: TableViewCellType) {
        self.selectedBackgroundImages[cellType] = image
    }
    
    public func setSelectedBackgroundColor(color: UIColor, forCellType cellType: TableViewCellType) {
        self.selectedBackgroundColors[cellType] = color
    }
}
