//
//  iiDateFormatterTests.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 30/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import WalkToCircle
import XCTest

class iiDateFormatterTests: XCTestCase {
  func testGetDateAsString() {
    let dateComponents = NSDateComponents()
    dateComponents.day = 12
    dateComponents.month = 3
    dateComponents.year = 2078

    let date: NSDate = NSCalendar.currentCalendar().dateFromComponents(dateComponents)!

    let result = iiDateFormatter.dateMonthDayYearAsString(date)
    XCTAssertEqual("2078.3.12", result)
  }
}