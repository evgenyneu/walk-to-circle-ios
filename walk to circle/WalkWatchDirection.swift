//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation

public struct WalkWatchDirection {
  public static var get: Int? {
    if let currentStart = start {
      if let currentEnd = end {
        let bearing = iiGeo.initialBearing(start: currentStart, end: currentEnd)
        return directionForBearing(bearing)
      }
    }

    return nil
  }

  public static func directionForBearing(bearing: Double) -> Int {
    var normalizedBearing = bearing % 360 // Make it less than 360

    // Translate negative bearing values to positive
    if normalizedBearing < 0 {
      normalizedBearing += 360
    }

    let direction = Int(round(normalizedBearing / degreesPerDirection))

    return direction % WalkConstants.watchOld.numberOfDirections // Make it less than numberOfDirections
  }

  private static var start: CLLocationCoordinate2D? {
    return WalkLocation.shared.lastLocation?.coordinate
  }

  private static var end: CLLocationCoordinate2D? {
    return WalkCoordinate.current
  }

  private static var degreesPerDirection: Double {
    return 360.0 / Double(WalkConstants.watchOld.numberOfDirections)
  }
}
