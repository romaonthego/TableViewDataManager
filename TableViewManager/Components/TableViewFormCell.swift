//
//  TableViewFormCell.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/6/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewFormCell: TableViewCell {

    @IBOutlet weak var labelCenterYConstraint: NSLayoutConstraint?
    @IBOutlet weak var labelRightMarginConstraint: NSLayoutConstraint?
    @IBOutlet weak var labelWidthConstraint: NSLayoutConstraint?
    @IBOutlet weak var titleLabel: UILabel?
    
    override func cellWillAppear() {
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
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let responder = self.responder() where selected {
            responder.becomeFirstResponder()
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        guard let titleLabel = self.titleLabel else {
            return
        }
        
        self.updateTitleLabelConstraints(titleLabel)
    }
    
    private func updateTitleLabelConstraints(titleLabel: UILabel) {
        if let labelWidthConstraint = self.labelWidthConstraint {
            if self.item.text != nil {
                var minWidth: Float = 0
                for item in self.section.items {
                    if let text = item.text {
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
