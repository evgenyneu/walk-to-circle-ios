//
//  iiDateFormatter.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 30/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public class iiDateFormatter {
  public class func dateMonthDayYearAsString(date: NSDate) -> String {
    let components = NSCalendar.currentCalendar().components(
      NSCalendarUnit.DayCalendarUnit |
      NSCalendarUnit.MonthCalendarUnit |
      NSCalendarUnit.YearCalendarUnit,
      fromDate: date)

    return "\(components.year).\(components.month).\(components.day)"
  }
}
