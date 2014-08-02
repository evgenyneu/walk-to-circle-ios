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
    let radians = geo.degreesToRadians(90)
    XCTAssertEqual(radians, M_PI / 2)
  }

  func testRadiansToDegrees() {
    let degress = geo.radiansToDegrees(M_PI)
    XCTAssertEqual(degress, 180.0)
  }

  func testDestinationWithDistanceAndBearing() {
    let coord = CLLocationCoordinate2DMake(-37.817728, 144.968108)
    let destination = geo.destination(coord, distanceKm: 0.5, bearingDegrees: 65)

    XCTAssertEqual(Int(destination.latitude * 100000), -3781582)

    XCTAssertEqual(Int(destination.longitude * 100000), 14497326)
  }

  func testRandomBetween() {
    for _ in 1...100 {
      let result = geo.randomBetween(min: 1, max: 5)

      XCTAssertGreaterThanOrEqual(result, 1)
      XCTAssertLessThanOrEqual(result, 5)
    }
  }

  func testRandomBearinDegrees() {
    for _ in 1...100 {
      let result = geo.randomBearinDegrees()

      XCTAssertGreaterThanOrEqual(result, 0)
      XCTAssertLessThanOrEqual(result, 360)
    }
  }

  func testRandomCoord() {
    let start = CLLocationCoordinate2DMake(-37.817728, 144.968108)

    for _ in 1...100 {
      let newCoordinate = geo.randomCoordinate(start, minDistanceKm: 1, maxDistanceKm: 5)

      let locationStart = CLLocation(latitude: start.latitude, longitude: start.longitude)
      let locationEnd = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)

      let distance = locationStart.distanceFromLocation(locationEnd)

      XCTAssertGreaterThanOrEqual(distance, 1000)
      XCTAssertLessThanOrEqual(distance, 5000)
    }
  }
}
