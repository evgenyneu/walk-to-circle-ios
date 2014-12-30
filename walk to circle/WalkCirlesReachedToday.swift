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
    let current = WalkUserDefaults.circlesReachedToday.intValue(0)
    WalkUserDefaults.circlesReachedToday.save(current + 1)
  }

  public class func increment(date: NSDate) {
    let dateStr = iiDateFormatter.dateMonthDayYearAsString(date)

    if WalkUserDefaults.lastCircleReachedDate_yearMonthDay.stringValue() == dateStr {
      increment()
    } else {
      WalkUserDefaults.lastCircleReachedDate_yearMonthDay.save(dateStr)
      WalkUserDefaults.circlesReachedToday.save(1)
    }
  }

  public class var number: Int {
    return WalkUserDefaults.circlesReachedToday.intValue(0)
  }

  public class func number(date: NSDate) -> Int {
    let dateStr = iiDateFormatter.dateMonthDayYearAsString(date)

    if WalkUserDefaults.lastCircleReachedDate_yearMonthDay.stringValue() == dateStr {
      return number
    }

    return 0
  }
}
