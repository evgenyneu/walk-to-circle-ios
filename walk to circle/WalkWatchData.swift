//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct WalkWatchData {
  public static var walkDirection: [String: AnyObject]? {
    if let currentData = data {
      return toDictionary(currentData)
    }

    return nil
  }

  public static func toDictionary(data: WalkWatch_directionModel) -> [String: AnyObject] {
    return [
      WalkConstants.watchOld.userLocation.name: [
        WalkConstants.watchOld.latitudeName: data.userLocation.latitude,
        WalkConstants.watchOld.longitudeName: data.userLocation.longitude
      ],

      WalkConstants.watchOld.circleDirectionName: data.circleDirection
    ]
  }

  public static var data: WalkWatch_directionModel? {
    if let currentUserLocation = WalkWatchUserLocation.userLocation {
      if let currentDirection = WalkWatchDirection.get {
        return WalkWatch_directionModel(
          userLocation: currentUserLocation,
          circleDirection: currentDirection
        )
      }
    }

    return nil
  }
}