//
// TableViewFormCell.swift
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

public class TableViewFormCell: TableViewCell {

    @IBOutlet var labelCenterYConstraint: NSLayoutConstraint?
    @IBOutlet var labelRightMarginConstraint: NSLayoutConstraint?
    @IBOutlet var labelWidthConstraint: NSLayoutConstraint?
    @IBOutlet var titleLabel: UILabel?
    
    public override func cellWillAppear() {
        updateActionBarNavigationControl()
        self.selectionStyle = .None
        
        guard let titleLabel = self.titleLabel else {
            return
        }
        titleLabel.text = self.item.text
        if let labelRightMarginConstraint = self.labelRightMarginConstraint {
            if let text = self.item.text where text.characters.count > 0 {
                labelRightMarginConstraint.constant = 13
            } else {
                labelRightMarginConstraint.constant = 0
            }
        }
    }
    
    public override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let responder = self.responder() where selected {
            responder.becomeFirstResponder()
        }
    }
    
    public override func updateConstraints() {
        super.updateConstraints()
        
        guard let titleLabel = self.titleLabel else {
            return
        }
        
        self.updateTitleLabelConstraints(titleLabel)
    }
    
    private func updateTitleLabelConstraints(titleLabel: UILabel) {
        if let labelWidthConstraint = self.labelWidthConstraint {
            if self.item.text != nil && self.item is TableViewFormItem {
                var minWidth: Float = 0
                for item in self.section.items {
                    if let text = item.text where item is TableViewFormItem {
                        let width = Float(NSString(string: text).boundingRectWithSize(CGSize(width: self.frame.size.width, height: CGFloat(DBL_MAX)),
                            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                            attributes: [NSFontAttributeName: titleLabel.font],
                            context: nil).size.width)
                        minWidth = max(width, minWidth)
                    }
                }
                labelWidthConstraint.constant = CGFloat(minWidth)
            } else {
                labelWidthConstraint.constant = 0
            }
        }
        
        // Fix label center Y
        //
        if let labelCenterYConstraint = self.labelCenterYConstraint {
            labelCenterYConstraint.constant = 0.5
        }
    }

}
