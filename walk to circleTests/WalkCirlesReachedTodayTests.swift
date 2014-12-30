//
//  CirlesReachedToday.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 30/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation
import WalkToCircle
import XCTest

class WalkCirlesReachedTodayTests: XCTestCase {
  func testIncrement() {
    WalkUserDefaults.circlesReachedToday.save(nil)

    WalkCirlesReachedToday.increment()

    XCTAssertEqual(1, WalkCirlesReachedToday.number)

    WalkCirlesReachedToday.increment()
    WalkCirlesReachedToday.increment()
    WalkCirlesReachedToday.increment()

    XCTAssertEqual(4, WalkCirlesReachedToday.number)
  }

  func testGetNumberOfCirclesReachedToday() {
    let components = NSCalendar.currentCalendar().components(NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.YearCalendarUnit, fromDate: NSDate())

    println("!!!!!!!!!!!!!!!!!!!! \(components.year).\(components.month).\(components.day)")
  }

  
}
