//
//  Created by Evgenii Neumerzhitckii on 9/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct WalkWatchData {
  public static var get: [String: AnyObject]? {
    if let currentUserLocation = WalkWatchUserLocation.userLocation {
      if let currentDirection = WalkWatchDirection.get {
        return [
          WalkConstants.watch.userLocation.name: currentUserLocation,
          WalkConstants.watch.circleDirectionName: currentDirection
        ]
      }
    }

    return nil
  }
}