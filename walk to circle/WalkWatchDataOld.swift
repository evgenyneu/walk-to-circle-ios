//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct WalkWatchDataOld {
  public static var walkDirection: [String: AnyObject]? {
    if let currentData = data {
      return toDictionary(currentData)
    }

    return nil
  }

  public static func toDictionary(data: WalkWatch_directionModelOld) -> [String: AnyObject] {
    return [
      WalkConstants.watchOld.userLocation.name: [
        WalkConstants.watchOld.latitudeName: data.userLocation.latitude,
        WalkConstants.watchOld.longitudeName: data.userLocation.longitude
      ],

      WalkConstants.watchOld.circleDirectionName: data.circleDirection
    ]
  }

  public static var data: WalkWatch_directionModelOld? {
    if let currentUserLocation = WalkWatchUserLocationOld.userLocation {
      if let currentDirection = WalkWatchDirectionOld.get {
        return WalkWatch_directionModelOld(
          userLocation: currentUserLocation,
          circleDirection: currentDirection
        )
      }
    }

    return nil
  }
}