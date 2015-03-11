//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation
import WalkToCircle
import XCTest

class WalkWatchDataTests: XCTestCase {
  func testData() {
    // 228 degress
    setTestUserLocation(CLLocationCoordinate2DMake(-37.847480, 144.969737))
    WalkCoordinate.current = CLLocationCoordinate2DMake(-37.879057, 144.924075)

    let result = WalkWatchData.get!

    let userLocation = result["userLocation"]! as [String: Double]
    let direction = result["circleDirection"]! as Int

    XCTAssertEqual(-37.847480, userLocation["latitude"]!)
    XCTAssertEqual(144.969737, userLocation["longitude"]!)

    XCTAssertEqual(10, direction)
  }

  func testData_noCircleDirection() {
    setTestUserLocation(CLLocationCoordinate2DMake(-37.847480, 144.969737))
    WalkCoordinate.current = nil // no current circle

    let result = WalkWatchData.get

    XCTAssert(result == nil)
  }

  func testData_noUserLocation() {
    WalkLocation.shared.lastLocation = nil // no User location
    WalkCoordinate.current = CLLocationCoordinate2DMake(-37.879057, 144.924075)

    let result = WalkWatchData.get

    XCTAssert(result == nil)
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