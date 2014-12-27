//
//  WalkCircleMonitor.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 27/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

private let walkCircleMonitor = WalkCircleMonitor()

class WalkCircleMonitor {
  private var region = CLCircularRegion()

  class var shared: WalkCircleMonitor {
    return walkCircleMonitor
  }

  private init() { }

  class func start() {
    if let currentCoordinate = WalkCoordinate.current {
      shared.start(currentCoordinate)
    }
  }

  private func start(coordinate: CLLocationCoordinate2D) {
    if alreadyUpdatingForCoordinate(coordinate) { return }

    region = WalkCircleMonitor.createRegion(coordinate)
    WalkLocation.shared.startUpdatingLocation()
  }

  class func stop() {
    WalkLocation.shared.stopUpdatingLocation()
  }

  func processLocationUpdate(location: CLLocation) {
    if region.containsCoordinate(location.coordinate) {
      WalkCircleMonitor.stop()

      locationReached()
    }
  }

  private func locationReached() {
    WalkNotification.showNow("You reached your circle. Congrats!")
    WalkViewControllers.Congrats.show()
  }

  private class func createRegion(coordinate: CLLocationCoordinate2D) -> CLCircularRegion {
    return CLCircularRegion(center: coordinate, radius: WalkConstants.regionCircleRadiusMeters,
      identifier: "walk circle")
  }

  private func alreadyUpdatingForCoordinate(location: CLLocationCoordinate2D) -> Bool {
    return WalkLocation.shared.updatingLocation &&
      region.center.latitude == location.latitude &&
      region.center.longitude == location.longitude
  }
}
