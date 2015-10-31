//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation
import WalkToCircle
import XCTest

class WalkWatchDataTests: XCTestCase {
  func testWalkDirection() {
    // 228 degress bearing
    setTestUserLocation(CLLocationCoordinate2DMake(-37.847480, 144.969737))
    WalkCoordinate.current = CLLocationCoordinate2DMake(-37.879057, 144.924075)

    let result = WalkWatchDataOld.walkDirection!

    let resultLocation = result["userLocation"] as! [String: Double]
    let direction = result["circleDirection"] as! Int

    XCTAssertEqual(-37.847480, resultLocation["latitude"]!)
    XCTAssertEqual(144.969737, resultLocation["longitude"]!)
    XCTAssertEqual(10, direction)
  }

  func testDataToDictionary() {
    let userLocation = WalkWatch_userLocationModelOld(latitude: 10, longitude: 2)
    let data = WalkWatch_directionModelOld(userLocation: userLocation, circleDirection: 3)

    let result = WalkWatchDataOld.toDictionary(data)

    let resultLocation = result["userLocation"] as! [String: Double]
    let direction = result["circleDirection"] as! Int

    XCTAssertEqual(10, resultLocation["latitude"]!)
    XCTAssertEqual(2, resultLocation["longitude"]!)
    XCTAssertEqual(3, direction)
  }

  // Get direction data object
  // ----------------------

  func testData() {
    // 228 degress bearing
    setTestUserLocation(CLLocationCoordinate2DMake(-37.847480, 144.969737))
    WalkCoordinate.current = CLLocationCoordinate2DMake(-37.879057, 144.924075)

    let result = WalkWatchDataOld.data!

    let userLocation = result.userLocation

    XCTAssertEqual(-37.847480, userLocation.latitude)
    XCTAssertEqual(144.969737, userLocation.longitude)
    XCTAssertEqual(10, result.circleDirection)
  }

  func testData_noCircleDirection() {
    setTestUserLocation(CLLocationCoordinate2DMake(-37.847480, 144.969737))
    WalkCoordinate.current = nil // no current circle

    let result = WalkWatchDataOld.data

    XCTAssert(result == nil)
  }

  func testData_noUserLocation() {
    WalkLocation.shared.lastLocation = nil // no user location
    WalkCoordinate.current = CLLocationCoordinate2DMake(-37.879057, 144.924075)

    let result = WalkWatchDataOld.data

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