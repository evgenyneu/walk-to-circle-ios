//
//  WalkLocation.swift
//
//  Singleton class that manages location.
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation

let iiWalkLocation = WalkLocation()

class WalkLocation: NSObject, CLLocationManagerDelegate {
  let locationManager = CLLocationManager()

  class var shared: WalkLocation {
    return iiWalkLocation
  }

  private override init() {
    super.init()
    locationManager.delegate = self
  }

  func requestAuthorization() {
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }
  }
}
