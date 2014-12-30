//
//  iiDateFormatter.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 30/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public class iiDate {
  public class func toStringAsYearMonthDay(date: NSDate) -> String {
    let components = NSCalendar.currentCalendar().components(
      NSCalendarUnit.DayCalendarUnit |
      NSCalendarUnit.MonthCalendarUnit |
      NSCalendarUnit.YearCalendarUnit,
      fromDate: date)

    return "\(components.year).\(components.month).\(components.day)"
  }

  public class func fromYearMonthDay(year: Int, month: Int, day: Int) -> NSDate? {
    let dateComponents = NSDateComponents()

    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day

    return NSCalendar.currentCalendar().dateFromComponents(dateComponents)
  }
}
