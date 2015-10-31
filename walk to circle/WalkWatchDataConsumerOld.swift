//
//  Created by Evgenii Neumerzhitckii on 11/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct WalkWatchDataConsumerOld {
  public static func fromDictionary(data: [String: AnyObject]) -> WalkWatch_directionModelOld? {
    let p = CutePossumParser(data: data)

    let data = WalkWatch_directionModelOld(
      userLocation: WalkWatch_userLocationModelOld(
        latitude: p["userLocation"].parse("latitude", miss: 0),
        longitude: p["userLocation"].parse("longitude", miss: 0)),
      circleDirection: p.parse("circleDirection", miss: 0)
    )

    if !p.success { return nil }

    return data
  }
}