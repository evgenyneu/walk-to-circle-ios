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
      WalkConstants.watch.userLocation.name: [
        WalkConstants.watch.latitudeName: data.userLocation.latitude,
        WalkConstants.watch.longitudeName: data.userLocation.longitude
      ],

      WalkConstants.watch.circleDirectionName: data.circleDirection
    ]
  }

  public static func fromDictionary(data: [String: AnyObject]) -> WalkWatch_directionModel? {
    let p = CutePossumParser(data: data)

    let data = WalkWatch_directionModel(
      userLocation: WalkWatch_userLocationModel(
        latitude: p["userLocation"].parse("latitude", miss: 0),
        longitude: p["userLocation"].parse("longitude", miss: 0)),
      circleDirection: p.parse("circleDirection", miss: 0)
    )

    if !p.success { return nil }

    return data
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