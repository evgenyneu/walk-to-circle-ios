//
//  WalkLocation.swift
//
//  Singleton class that manages location.
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
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

  func start() {
    checkAuthorizationStatus(CLLocationManager.authorizationStatus())
  }

  func checkAuthorizationStatus(status: CLAuthorizationStatus) {
    switch status {
    case .Authorized:
      WalkViewControllers.Map.show()
      
    case .Denied, .Restricted:
      WalkViewControllers.LocationDenied.show()
      
    case .NotDetermined:
      if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
        locationManager.requestAlwaysAuthorization()
      }
    default:
      let none = 0
    }
  }
}

// CLLocationManagerDelegate
// ------------------------------

typealias WalkLocation_LocationManagerDelegate_Implementation = WalkLocation

extension WalkLocation_LocationManagerDelegate_Implementation {

  func locationManager(manager: CLLocationManager!,
    didChangeAuthorizationStatus status: CLAuthorizationStatus) {

    checkAuthorizationStatus(status)
  }
}
