//
//  TableViewDateItem.swift
//  TableViewManager
//
//  Created by Roman Efimov on 3/26/15.
//  Copyright (c) 2015 Roman Efimov. All rights reserved.
//

import UIKit

public class TableViewDateTimeItem: TableViewFormItem {
   
    public var value: NSDate?
    public var selected: Bool = false
    public var pickerStartDate: NSDate? // date to be used for the picker when the value is not set; defaults to current date when not specified
    public var placeholder: String?
    public var format: String {
        get {
            return self.dateFormatter.dateFormat
        }
        set {
            self.dateFormatter.dateFormat = newValue
        }
    }
    public var datePickerMode: UIDatePickerMode = .DateAndTime
    
    public var locale: NSLocale? // default is [NSLocale currentLocale]. setting nil returns to default
    public var calendar: NSCalendar? // default is [NSCalendar currentCalendar]. setting nil returns to default
    public var timeZone: NSTimeZone? // default is nil. use current time zone or time zone from calendar
    
    public var minimumDate: NSDate? // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
    public var maximumDate: NSDate? // default is nil
    public var minuteInterval: NSInteger = 1 // display minutes wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30
    
    public lazy var dateFormatter: NSDateFormatter = NSDateFormatter()
    
    // MARK: Instance Lifecycle
    //
    public convenience init(text: String?, placeholder: String?, value: NSDate!, format: String!, datePickerMode: UIDatePickerMode!) {
        self.init(text: text)
        self.value = value
        self.placeholder = placeholder
        self.format = format
        self.datePickerMode = datePickerMode
    }
    
}
