//
//  GeoTests.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 19/07/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import XCTest
import CoreLocation

class GeoTests: XCTestCase {

  let geo = Geo()

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testDegreesToRadians() {
    var radians = geo.degreesToRadians(90)
    XCTAssertEqual(radians, M_PI / 2)
  }

  func testRadiansToDegrees() {
    var degress = geo.radiansToDegrees(M_PI)
    XCTAssertEqual(degress, 180.0)
  }

  func testDestinationWithDistanceAndBearing() {
    let coord = CLLocationCoordinate2DMake(-37.817728, 144.968108)
    var destination = geo.destination(coord, distanceKm: 0.5, bearingDegrees: 65)

    XCTAssertEqual(Int(destination.latitude * 100000), -3781582)

    XCTAssertEqual(Int(destination.longitude * 100000), 14497326)
  }
}
