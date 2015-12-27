//
//  TableViewDatePickerItem.swift
//  Example
//
//  Created by Roman Efimov on 12/27/15.
//  Copyright © 2015 Roman Efimov. All rights reserved.
//

import UIKit

class TableViewDatePickerItem: TableViewFormItem {
    
    var value: NSDate!
    
    var pickerStartDate: NSDate? // date to be used for the picker when the value is not set; defaults to current date when not specified
    var placeholder: String?
    var format: String!
    var datePickerMode: UIDatePickerMode = .DateAndTime
    
    var locale: NSLocale? // default is [NSLocale currentLocale]. setting nil returns to default
    var calendar: NSCalendar? // default is [NSCalendar currentCalendar]. setting nil returns to default
    var timeZone: NSTimeZone? // default is nil. use current time zone or time zone from calendar
    
    var minimumDate: NSDate? // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
    var maximumDate: NSDate? // default is nil
    var minuteInterval: NSInteger = 1 // display minutes wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30
    
    // MARK: Instance Lifecycle
    //
    convenience init(text: String?, value: NSDate!, format: String!, datePickerMode: UIDatePickerMode!) {
        self.init(text: text)
        self.value = value
    }
    
}

