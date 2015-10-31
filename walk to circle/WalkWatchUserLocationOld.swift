//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct WalkWatchUserLocationOld {
  public static var userLocation: WalkWatch_userLocationModelOld? {
    if let currentLastLocation = WalkLocation.shared.lastLocation {

      if !isLocationFresh(currentLastLocation.timestamp) { return nil }

      return WalkWatch_userLocationModelOld(
        latitude: currentLastLocation.coordinate.latitude,
        longitude: currentLastLocation.coordinate.longitude)
    }

    return nil
  }

  public static func isLocationFresh(date: NSDate) -> Bool {
    let secondsUpdating = NSDate().timeIntervalSinceDate(date)
    return secondsUpdating < WalkConstants.watchOld.userLocation.maxLocationAgeInSeconds
  }
}
