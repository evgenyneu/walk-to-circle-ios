//
//  WalkCoordinate.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 22/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

public class WalkCoordinate {
  public class func clearCurrent() {
    current = nil
  }

  public class var current: CLLocationCoordinate2D? {
    get {
      if let currentLatitude =
        WalkUserDefaults.currentCircleCoordinateLatitude.value as? CLLocationDegrees {

        if let currentLongitude =
          WalkUserDefaults.currentCircleCoordinateLongitude.value as? CLLocationDegrees {

          return CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        }
      }

      return nil
    }

    set {
      if let currentLocation = newValue {
        WalkUserDefaults.currentCircleCoordinateLatitude.save(currentLocation.latitude)
        WalkUserDefaults.currentCircleCoordinateLongitude.save(currentLocation.longitude)
      } else {
        // remove
        WalkUserDefaults.currentCircleCoordinateLatitude.save(nil)
        WalkUserDefaults.currentCircleCoordinateLongitude.save(nil)
      }
    }
  }
}

