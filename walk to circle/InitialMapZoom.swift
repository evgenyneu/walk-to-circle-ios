//
//  InitialMapZoom.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 12/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

class InitialMapZoom {
  class func isZoomLevelOk(mapRect: MKMapRect) -> Bool {
    let mapSize = iiGeo.mapSizeInMeters(mapRect)
    let maxSize = max(mapSize.width, mapSize.height)
    let minSize = min(mapSize.width, mapSize.height)

    return minSize < 6_000 && maxSize > 3_000
  }
}