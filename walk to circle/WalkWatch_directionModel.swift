//
//  Created by Evgenii Neumerzhitckii on 11/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct WalkWatch_directionModelOld {
  public init(userLocation: WalkWatch_userLocationModelOld, circleDirection: Int) {
    self.userLocation = userLocation
    self.circleDirection = circleDirection
  }

  public let userLocation: WalkWatch_userLocationModelOld
  public let circleDirection: Int
}