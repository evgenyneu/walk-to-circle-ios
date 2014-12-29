//
//  WalkCoordinateTests.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 29/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation
import WalkToCircle
import XCTest


class WalkCoordinateTests: XCTestCase {
  func testSetAndGetCurrent() {
    WalkCoordinate.current = CLLocationCoordinate2D(latitude: 30, longitude: 10)
    XCTAssertEqual(30, WalkCoordinate.current!.latitude)
    XCTAssertEqual(10, WalkCoordinate.current!.longitude)
  }

  func testClearCurrentCoordinate() {
    WalkCoordinate.previous = nil
    WalkCoordinate.current = CLLocationCoordinate2D(latitude: 21, longitude: 14)

    WalkCoordinate.clearCurrent()

    XCTAssertTrue(WalkCoordinate.current == nil)

    // Save current to previous
    XCTAssertEqual(21, WalkCoordinate.previous!.latitude)
    XCTAssertEqual(14, WalkCoordinate.previous!.longitude)
  }

  func testSetAndGetPrevious() {
    WalkCoordinate.previous = CLLocationCoordinate2D(latitude: 40, longitude: 15)
    XCTAssertEqual(40, WalkCoordinate.previous!.latitude)
    XCTAssertEqual(15, WalkCoordinate.previous!.longitude)
  }
}
