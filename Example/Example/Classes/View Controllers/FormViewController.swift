//
//  FormViewController.swift
//  Example
//
//  Created by Roman Efimov on 3/5/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

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
                self.dateTimeItem
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
        print("Full length text field value: \(self.fullLengthTextField.value)")
    }
}
