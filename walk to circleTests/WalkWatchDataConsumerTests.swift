//
//  Created by Evgenii Neumerzhitckii on 11/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation
import WalkToCircle
import XCTest

class WalkWatchDataConsumeTests: XCTestCase {

  func testDataFromDictionary() {
    let dict = [
      "userLocation": [
        "latitude": 1.123,
        "longitude": 5.567
      ],

      "circleDirection": 14
      ] as [String: AnyObject]

    let result = WalkWatchDataConsumer.fromDictionary(dict)!

    XCTAssertEqual(1.123, result.userLocation.latitude)
    XCTAssertEqual(5.567, result.userLocation.longitude)
    XCTAssertEqual(14, result.circleDirection)
  }
}
