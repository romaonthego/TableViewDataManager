//
// TableViewDateItem.swift
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
