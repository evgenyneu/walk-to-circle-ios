//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct WalkWatchUserLocation {
  public static var userLocation: [String: Double]? {
    if let currentLastLocation = WalkLocation.shared.lastLocation {

      if !isLocationFresh(currentLastLocation.timestamp) { return nil }

      return [
        WalkConstants.watch.latitudeName: currentLastLocation.coordinate.latitude,
        WalkConstants.watch.longitudeName: currentLastLocation.coordinate.longitude,
      ]
    }

    return nil
  }

  public static func isLocationFresh(date: NSDate) -> Bool {
    let secondsUpdating = NSDate().timeIntervalSinceDate(date)
    return secondsUpdating < WalkConstants.watch.userLocation.maxLocationAgeInSeconds
  }
}
