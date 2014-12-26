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
  private let locationManager = CLLocationManager()

  class var shared: WalkLocation {
    return iiWalkLocation
  }

  private override init() {
    super.init()
    locationManager.delegate = self
  }

  func reactToCurrentAuthorizationStatus() {
    checkAuthorizationStatus(CLLocationManager.authorizationStatus())
  }

  func checkAuthorizationStatus(status: CLAuthorizationStatus) {
    if !CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion) {
      // Region monitoring is not available on the hardware,
      // which means that our app is not functional on this device.
      WalkViewControllers.RegionMonitoringUnavailable.show()
      return
    }

    switch status {
    case .Authorized:
      WalkViewControllers.currentNonError.show()
      
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

  func startUpdatingLocation() {
    stopUpdatingLocation()

    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.distanceFilter = 10

    locationManager.startUpdatingLocation()
  }

  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
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

  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    for location in locations {
      if let currentLocation = location as? CLLocation {
        WalkCircleMonitor.shared.processLocationUpdate(currentLocation)
      }
    }
  }

  func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    let title = "Location Error"
    let message = iiCLErrorToString.toString(error.code) + " " + error.description

    let alert = UIAlertView(title: title, message: message, delegate: nil,
      cancelButtonTitle: "Close")

    WalkNotification.showNow("\(title): \(message)")
    alert.show()
  }
}
