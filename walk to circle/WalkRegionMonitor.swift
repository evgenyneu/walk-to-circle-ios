//
//  WalkRegionMonitor.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

let iiWalkRegionId = "walk to circle region"
let iiWalkRegionSize = CLLocationDistance(100)


class WalkRegionMonitor {
  class func startMonitoringForRegion(coordinate: CLLocationCoordinate2D) {
    let region = createRegion(coordinate)
    WalkLocation.shared.startMonitoringForRegion(region)
  }

  private class func createRegion(coordinate: CLLocationCoordinate2D) -> CLCircularRegion {
    return CLCircularRegion(center: coordinate,
      radius: iiWalkRegionSize, identifier: iiWalkRegionId)
  }
}