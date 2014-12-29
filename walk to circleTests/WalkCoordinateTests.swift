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
  func testSetAndGet() {
    WalkCoordinate.current = CLLocationCoordinate2D(latitude: 30, longitude: 10)
    XCTAssertEqual(30, WalkCoordinate.current!.latitude)
    XCTAssertEqual(10, WalkCoordinate.current!.longitude)
  }

  func testClearCurrentCoordinate() {
    WalkCoordinate.current = CLLocationCoordinate2D(latitude: 30, longitude: 10)
    WalkCoordinate.clearCurrent()
    XCTAssertTrue(WalkCoordinate.current == nil)
  }
}
