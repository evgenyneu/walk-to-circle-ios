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
    WalkUserDefaults.circlesReachedToday.clear()
    WalkUserDefaults.lastCircleReachedDate_yearMonthDay.clear()

    WalkCirlesReachedToday.increment()

    XCTAssertEqual(1, WalkCirlesReachedToday.number)

    WalkCirlesReachedToday.increment()
    WalkCirlesReachedToday.increment()
    WalkCirlesReachedToday.increment()

    XCTAssertEqual(4, WalkCirlesReachedToday.number)
  }

  func testGetNumberOfCirclesReachedForDate() {
    WalkUserDefaults.circlesReachedToday.clear()
    WalkUserDefaults.lastCircleReachedDate_yearMonthDay.clear()

    let dateComponents = NSDateComponents()
    dateComponents.day = 4
    dateComponents.month = 5
    dateComponents.year = 2031
    let date: NSDate = NSCalendar.currentCalendar().dateFromComponents(dateComponents)!

    var result = WalkCirlesReachedToday.number(date)
    XCTAssertEqual(0, result)

    WalkCirlesReachedToday.increment(date)
    WalkCirlesReachedToday.increment(date)

    result = WalkCirlesReachedToday.number(date)

    XCTAssertEqual(2, result)

  }

  
}
