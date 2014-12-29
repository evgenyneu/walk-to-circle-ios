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
  private var locationUpdateStarted: NSDate?

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
    locationManager.pausesLocationUpdatesAutomatically = false

    locationManager.startUpdatingLocation()
    locationUpdateStarted = NSDate()
  }

  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
    locationUpdateStarted = nil
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
    if updatingLocationForTooLong {
      // The location updates were running for too long
      // User has probably abandoned the app.
      // Dtop location updates to preserve the battery life.
      // Location updates will be restarted when/if the app is opened again.
      stopUpdatingLocation()
    }

    for (index, location) in enumerate(locations) {
      if index >= WalkConstants.maxNumberOfLocationsToProcessInSingleLocationUpdate { return }

      if let currentLocation = location as? CLLocation {
        if WalkCircleMonitor.shared.processLocationUpdate(currentLocation) { return }
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
  
  var updatingLocationForTooLong: Bool {
    if let currentLocateUpdateStartDate = locationUpdateStarted {
      let secondsUpdating = NSDate().timeIntervalSinceDate(currentLocateUpdateStartDate)
      return secondsUpdating > WalkConstants.maxLocationUpdatePeriodSeconds
    }

    return false
  }
}
