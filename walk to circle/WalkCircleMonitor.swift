//
//  WalkCircleMonitor.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 27/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

let walkCircleMonitor = WalkCircleMonitor()

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
    region = WalkCircleMonitor.createRegion(coordinate)
    WalkLocation.shared.startUpdatingLocation()
  }

  class func stop() {
    WalkLocation.shared.stopUpdatingLocation()
  }

  func processLocationUpdate(location: CLLocation) {
    
  }

  private class func createRegion(coordinate: CLLocationCoordinate2D) -> CLCircularRegion {
    return CLCircularRegion(center: coordinate, radius: WalkConstants.regionCircleRadiusMeters,
      identifier: nil)
  }
}
