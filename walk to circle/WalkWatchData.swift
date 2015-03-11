//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct WalkWatchData {

  public static var get: WalkWatch_directionModel? {
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