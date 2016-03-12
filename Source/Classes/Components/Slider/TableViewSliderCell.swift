//
//  TableViewSliderCell.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewSliderCell: TableViewFormCell {

    // MARK: Public variables
    //
    public override var item: TableViewItem! { get { return sliderItem } set { sliderItem = newValue as! TableViewSliderItem } }
    
    // MARK: Private variables
    //
    private var sliderItem: TableViewSliderItem!
    
    // MARK: Interface builder outlets
    //
    @IBOutlet weak var slider: UISlider!
    
    // MARK: View Lifecycle
    //
    public override func cellDidLoad() {
        super.cellDidLoad()
    }
    
    public override func cellWillAppear() {
        super.cellWillAppear()
        slider.value = self.sliderItem.value
    }
    
    // MARK: Actions
    //
    @IBAction func sliderValueChanged(sender: UISlider!) {
        self.sliderItem.value = sender.value
        guard let changeHandler = self.sliderItem.changeHandler, let tableView = self.tableViewManager.tableView, let indexPath = self.indexPath else {
            return
        }
        changeHandler(section: self.section, item: self.sliderItem, tableView: tableView, indexPath: indexPath)
    }
}
