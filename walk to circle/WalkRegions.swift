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


// These values were determined experimentally.
// When we monitor for a region of 100m radius, it sends 'region enter'
// when we are about 130m from its center.
// So we monitor for 100m but draw the overlay of 130m meters on the map

// Region enter even location may still vary plus/minus 30m in a city,
// because region monitoring is using WiFi location techniques.

let iiWalkRegionCircleRadiusMeters = CLLocationDistance(100)
let iiWalkRegionOverlayCircleRadiusMeters = CLLocationDistance(130)


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
      radius: iiWalkRegionCircleRadiusMeters, identifier: iiWalkRegionId)
  }

  class var locationManager: CLLocationManager {
    return WalkLocation.shared.locationManager
  }
}