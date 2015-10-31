//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation
import WalkToCircle
import XCTest

class WalkWatchWalkDirectionTests: XCTestCase {

  // Get direction
  // ---------------

  func testGetDirection() {
    // 136 degress
    setTestUserLocation(CLLocationCoordinate2DMake(-37.847480, 144.969737))
    WalkCoordinate.current = CLLocationCoordinate2DMake(-37.861644, 144.986903)

    let result = WalkWatchDirectionOld.get!

    XCTAssertEqual(6, result)
  }

  func testGetDirection_noCurrentCircle() {
    setTestUserLocation(CLLocationCoordinate2DMake(-37.847480, 144.969737))
    WalkCoordinate.clearCurrent() // No current circle

    let result = WalkWatchDirectionOld.get

    XCTAssert(result == nil)
  }

  func testGetDirection_noUserLocation() {
    WalkLocation.shared.lastLocation = nil // No current user location
    WalkCoordinate.current = CLLocationCoordinate2DMake(-37.861644, 144.986903)

    let result = WalkWatchDirectionOld.get

    XCTAssert(result == nil)
  }

  // directionForBearing
  // ---------------

  func testDirectionForBearing() {
    XCTAssertEqual(0, WalkWatchDirectionOld.directionForBearing(0))
    XCTAssertEqual(1, WalkWatchDirectionOld.directionForBearing(22.5))
    XCTAssertEqual(1, WalkWatchDirectionOld.directionForBearing(30))
    XCTAssertEqual(2, WalkWatchDirectionOld.directionForBearing(40))
    XCTAssertEqual(4, WalkWatchDirectionOld.directionForBearing(90))
    XCTAssertEqual(8, WalkWatchDirectionOld.directionForBearing(180))
    XCTAssertEqual(12, WalkWatchDirectionOld.directionForBearing(270))
    XCTAssertEqual(0, WalkWatchDirectionOld.directionForBearing(359))

    // Edge cases
    XCTAssertEqual(0, WalkWatchDirectionOld.directionForBearing(360))
    XCTAssertEqual(2, WalkWatchDirectionOld.directionForBearing(405)) // 360 + 45 degrees
    XCTAssertEqual(12, WalkWatchDirectionOld.directionForBearing(-90)) // 270 degrees
    XCTAssertEqual(12, WalkWatchDirectionOld.directionForBearing(-450)) // 270 degrees
  }

  private func setTestUserLocation(coordinate: CLLocationCoordinate2D) {
    let location = CLLocation(
      coordinate: coordinate,
      altitude: 0,
      horizontalAccuracy: 0,
      verticalAccuracy: 0,
      course: 0,
      speed: 0,
      timestamp: NSDate())

    WalkLocation.shared.lastLocation = location
  }
}
