//
//  WalkCirlesReachedToday.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 30/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public class WalkCirlesReachedToday {
  public class func increment() {
    increment(NSDate())
  }

  public class func increment(date: NSDate) {
    let dateStr = iiDate.toStringAsYearMonthDay(date)

    var value = number(date)

    if WalkUserDefaults.lastCircleReachedDate_yearMonthDay.stringValue() != dateStr {
      // We have not reached circles today, update the date
      WalkUserDefaults.lastCircleReachedDate_yearMonthDay.save(dateStr)
    }

    value++
    WalkUserDefaults.circlesReachedToday.save(value)
  }

  public class var number: Int {
    return number(NSDate())
  }

  public class func number(date: NSDate) -> Int {
    let dateStr = iiDate.toStringAsYearMonthDay(date)

    if WalkUserDefaults.lastCircleReachedDate_yearMonthDay.stringValue() == dateStr {
      return WalkUserDefaults.circlesReachedToday.intValue(0)
    }

    return 0
  }
}
