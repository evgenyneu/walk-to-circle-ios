//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation
import WalkToCircle
import XCTest

class WalkWatchUserLocationTests: XCTestCase {
  func testCurrentUserLocation() {
    let coordinate = CLLocationCoordinate2D(latitude: -37.863471, longitude: 144.983910)

    let location = CLLocation(
      coordinate: coordinate,
      altitude: 0,
      horizontalAccuracy: 0,
      verticalAccuracy: 0,
      course: 0,
      speed: 0,
      timestamp: NSDate())

    WalkLocation.shared.lastLocation = location

    let result = WalkWatchUserLocation.userLocation!

    XCTAssertEqual(-37.863471, result["latitude"]!)
    XCTAssertEqual(144.983910, result["longitude"]!)
  }

  func testCurrentUserLocation_locationUpdateIsMissing() {
    WalkLocation.shared.lastLocation = nil

    let result = WalkWatchUserLocation.userLocation

    XCTAssert(result == nil)
  }

  func testCurrentUserLocation_whenLocationIsOld() {
    let coordinate = CLLocationCoordinate2D(latitude: -37.863471, longitude: 144.983910)

    let location = CLLocation(
      coordinate: coordinate,
      altitude: 0,
      horizontalAccuracy: 0,
      verticalAccuracy: 0,
      course: 0,
      speed: 0,
      timestamp: NSDate().dateByAddingTimeInterval(-70))

    WalkLocation.shared.lastLocation = location

    let result = WalkWatchUserLocation.userLocation

    XCTAssert(result == nil)
  }

  // Is location fresh
  // -----------------
  func testIsLocationFresh_Yes() {
    let result = WalkWatchUserLocation.isLocationFresh(NSDate())

    XCTAssert(result)
  }

  func testIsLocationFresh_No() {
    let result = WalkWatchUserLocation.isLocationFresh(NSDate().dateByAddingTimeInterval(-40))

    XCTAssertFalse(result)
  }

}