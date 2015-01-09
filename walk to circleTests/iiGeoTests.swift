//
//  iiGeoTests.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 19/07/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import XCTest
import CoreLocation

class iiGeoTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testDegreesToRadians() {
    let radians = iiGeo.degreesToRadians(90)
    XCTAssertEqual(radians, M_PI / 2)
  }

  func testRadiansToDegrees() {
    let degress = iiGeo.radiansToDegrees(M_PI)
    XCTAssertEqual(degress, 180.0)
  }

  func testDestinationWithDistanceAndBearing() {
    let coord = CLLocationCoordinate2DMake(-37.817728, 144.968108)
    let destination = iiGeo.destination(coord, distanceMeters: 500, bearingDegrees: 65)

    XCTAssertEqual(Int(destination.latitude * 100000), -3781582)

    XCTAssertEqual(Int(destination.longitude * 100000), 14497326)
  }

  func testRandomBetween() {
    for _ in 1...1000 {
      let result = iiGeo.randomBetween(min: 1000, max: 5000)

      XCTAssertGreaterThanOrEqual(result, 1000)
      XCTAssertLessThanOrEqual(result, 5000)
    }
  }

  func testRandomBearinDegrees() {
    for _ in 1...100 {
      let result = iiGeo.randomBearinDegrees()

      XCTAssertGreaterThanOrEqual(result, 0)
      XCTAssertLessThanOrEqual(result, 360)
    }
  }

  func testRandomCoord() {
    let start = CLLocationCoordinate2DMake(-37.817728, 144.968108)

    for _ in 1...1000 {
      let newCoordinate = iiGeo.randomCoordinate(start,
        minDistanceMeters: 1000, maxDistanceMeters: 5000)

      let locationStart = CLLocation(latitude: start.latitude, longitude: start.longitude)
      let locationEnd = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)

      let distance = locationStart.distanceFromLocation(locationEnd)

      XCTAssertGreaterThanOrEqual(distance, 1000)
      XCTAssertLessThanOrEqual(distance, 5000)
    }
  }

  func testInitialBearing_one() {
    let start = CLLocationCoordinate2DMake(-37.847480, 144.969737)
    let end = CLLocationCoordinate2DMake(-37.861644, 144.986903)

    let result = iiGeo.initialBearing(start: start, end: end)

    XCTAssertEqual(136, Int(result))
  }

  func testInitialBearing_two() {
    let start = CLLocationCoordinate2DMake(-37.847480, 144.969737)
    let end = CLLocationCoordinate2DMake(-37.879057, 144.924075)

    let result = iiGeo.initialBearing(start: start, end: end)

    XCTAssertEqual(228, Int(result))
  }
}
