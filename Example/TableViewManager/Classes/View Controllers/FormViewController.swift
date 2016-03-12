//
// FormViewController.swift
// TableViewManager
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
import TableViewManager

class FormViewController: UITableViewController {

    // MARK: Lazy initialize the table view manager
    //
    lazy var manager: TableViewManager = TableViewManager(tableView: self.tableView)
    
    // MARK: Lazy initialize form fields
    //
    lazy var fullLengthTextField = TableViewTextFieldItem(text: nil, placeholder: "Full length text field", value: nil)
    lazy var textItem = TableViewTextFieldItem(text: "Text item", placeholder: "Placeholder text", value: nil)
    lazy var numberItem = TableViewTextFieldItem(text: "Phone", placeholder: "(123) 456-7890", value: nil)
    lazy var passwordItem: TableViewTextFieldItem = {
        let item = TableViewTextFieldItem(text: "Password", placeholder: "Password item", value: nil)
        item.secureTextEntry = true
        return item
    }()
    lazy var switchItem: TableViewSwitchItem = {
        let item = TableViewSwitchItem(text: "Switch", value: true)
        item.changeHandler = { (section: TableViewSection, item: TableViewSwitchItem, tableView: UITableView, indexPath: NSIndexPath) in
            print("Switch value: \(item.value)")
        }
        return item
    }()
    lazy var sliderItem: TableViewSliderItem = {
        let item = TableViewSliderItem(text: "Slider", value: 0.2)
        item.changeHandler = { (section: TableViewSection, item: TableViewSliderItem, tableView: UITableView, indexPath: NSIndexPath) in
            print("Slider value: \(item.value)")
        }
        return item
    }()
    lazy var dateTimeItem: TableViewDateTimeItem = {
        let item = TableViewDateTimeItem(text: "Date / Time", placeholder: nil, value: NSDate(), format: "MM/dd/yyyy hh:mm a", datePickerMode: .DateAndTime)
        return item
    }()
    lazy var pickerItem: TableViewPickerItem = {
        let item = TableViewPickerItem(
            text: "Picker",
            placeholder: "Test",
            value: ["Item 12", "Item 23"],
            options: [
                ["Item 11", "Item 12", "Item 13"],
                ["Item 21", "Item 22", "Item 23", "Item 24"]
            ]
        )
        return item
    }()
    lazy var segmentedControlItem: TableViewSegmentedControlItem = {
        let item = TableViewSegmentedControlItem(text: "Segmented Control", items: ["One", "Two", UIImage(named: "Heart")!], value: 1)
        item.selectable = false
        item.changeHandler = { (section: TableViewSection, item: TableViewSegmentedControlItem, tableView: UITableView, indexPath: NSIndexPath) in
            print("Segmented Control value: \(item.value)")
        }
        return item
    }()
    lazy var textViewItem: TableViewTextViewItem = {
        let item = TableViewTextViewItem(text: nil, value: "Text View\nMulti line")
        item.height = 100
        item.returnKeyHandler = { (section: TableViewSection, item: TableViewTextViewItem, tableView: UITableView, indexPath: NSIndexPath) in
            print("Value: \(item.value)")
        }
        return item
    }()
    lazy var multiLineTextItem: TableViewItem = {
        let item = TableViewItem(text: "Custom item / cell example. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sem leo, malesuada tempor metus et, elementum pulvinar nibh.")
        item.selectable = false
        return item
    }()
    lazy var imageAndTextItem: TableViewItem = {
        let item = TableViewItem(text: "Image and text", image: UIImage(named: "Heart")!)
        item.selectable = false
        return item
    }()
    
    // MARK: View Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataSource = self.manager.dataSource else {
            return
        }
        
        // Form items section
        //
        dataSource.sections.append({
            let section = TableViewSection(headerTitle: "Form items")
            section.items = [
                self.fullLengthTextField,
                self.textItem,
                self.numberItem,
                self.passwordItem,
                self.switchItem,
                self.sliderItem,
                self.dateTimeItem,
                self.pickerItem,
                self.segmentedControlItem,
                self.textViewItem,
                self.multiLineTextItem,
                self.imageAndTextItem
            ]
            return section
        }())
        
        // Accessories section
        //
        dataSource.sections.append({
            let section = TableViewSection(headerTitle: "Accessories", footerTitle: "This section holds cells with accessories.")
            section.items = [
                TableViewItem(text: "Accessory 1", configurationHandler: { (tableViewCell: TableViewCell) -> (Void) in
                    tableViewCell.accessoryType = .DisclosureIndicator
                }),
                {
                    let item = TableViewItem(text: "Accessory 2", configurationHandler: { (tableViewCell: TableViewCell) -> (Void) in
                        tableViewCell.accessoryType = .DetailDisclosureButton
                    })
                    item.accessoryButtonTapHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
                        print("Accessory button tapped")
                    }
                    return item
                }(),
                TableViewItem(text: "Accessory 3", configurationHandler: { (tableViewCell: TableViewCell) -> (Void) in
                    tableViewCell.accessoryType = .Checkmark
                })
            ]
            return section
        }())
        
        // Copy / Cut / Paste section
        //
        dataSource.sections.append({
            let section = TableViewSection(headerTitle: "Copy / Cut / Paste", footerTitle: "his section holds items that support copy and pasting. You can tap on an item to copy it, while you can tap on another one to paste it.")
            section.items = [
                {
                    let item = TableViewItem(text: "Long tap to copy this item", selectionHandler: { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
                        tableView.deselectRowAtIndexPath(indexPath, animated: true)
                    })
                    item.copyHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
                        UIPasteboard.generalPasteboard().string = "Copied item #1"
                    }
                    return item
                }(),
                {
                    let item = TableViewItem(text: "Long tap to paste into this item", selectionHandler: { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
                        tableView.deselectRowAtIndexPath(indexPath, animated: true)
                    })
                    item.pasteHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
                        item.text = UIPasteboard.generalPasteboard().string
                        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    }
                    return item
                }(),
                {
                    let item = TableViewItem(text: "Long tap to cut text from this item", selectionHandler: { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
                        tableView.deselectRowAtIndexPath(indexPath, animated: true)
                    })
                    item.cutHandler = { (section: TableViewSection, item: TableViewItem, tableView: UITableView, indexPath: NSIndexPath) -> (Void) in
                        item.text = "(Empty)"
                        UIPasteboard.generalPasteboard().string = "Copied item #3"
                        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    }
                    return item
                }()
            ]
            return section
        }())
    }
    
    // MARK: Read values
    //
    @IBAction func valuesButtonPressed(sender: AnyObject) {
        print("fullLengthTextField.value = \(self.fullLengthTextField.value)")
        print("textItem.value = \(self.textItem.value)")
        print("numberItem.value = \(self.numberItem.value)")
        print("passwordItem.value = \(self.passwordItem.value)")
        print("switchItem.value = \(self.switchItem.value)")
        print("sliderItem.value = \(self.sliderItem.value)")
        print("dateTimeItem.value = \(self.dateTimeItem.value)")
        print("pickerItem.value = \(self.pickerItem.value)")
        print("segmentedControlItem.value = \(self.segmentedControlItem.value)")
        print("textViewItem.value = \(self.textViewItem.value)")
    }
}
