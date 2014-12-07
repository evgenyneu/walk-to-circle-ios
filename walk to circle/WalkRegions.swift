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

class WalkRegions {
  class func startMonitoringForCoordinate(coordinate: CLLocationCoordinate2D) {
    let region = createRegion(coordinate)

    stopMonitoringForAllRegions()

    iiQ.runAfterDelay(1) {
      self.startMonitoringForRegion(region)
    }
  }

  private class func startMonitoringForRegion(region: CLRegion) {
    stopMonitoringForAllRegions()

    iiQ.runAfterDelay(1) {
      self.locationManager.startMonitoringForRegion(region)
    }
  }

  class func stopMonitoringForAllRegions() {
    for monitoredRegion in locationManager.monitoredRegions {
      if let currentMonitoredRegion = monitoredRegion as? CLRegion {
        self.locationManager.stopMonitoringForRegion(currentMonitoredRegion)
      }
    }
  }

  private class func createRegion(coordinate: CLLocationCoordinate2D) -> CLCircularRegion {
    return CLCircularRegion(center: coordinate,
      radius: iiWalkRegionSize, identifier: iiWalkRegionId)
  }

  class var locationManager: CLLocationManager {
    return WalkLocation.shared.locationManager
  }
}