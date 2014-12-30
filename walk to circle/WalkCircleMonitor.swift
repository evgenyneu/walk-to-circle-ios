//
//  WalkCircleMonitor.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 27/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

private let walkCircleMonitor = WalkCircleMonitor()

@objc
class WalkCircleMonitor {
  private var region = CLCircularRegion()
  class var shared: WalkCircleMonitor {
    return walkCircleMonitor
  }

  private init() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
  }

  func applicationWillEnterForeground(notification: NSNotification) {
    // We need to restart monitoring in case it was stopped
    WalkCircleMonitor.start()
  }

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

  func processLocationUpdate(location: CLLocation) -> Bool {
    if region.containsCoordinate(location.coordinate) {
      locationReached()
      return true
    }

    return false
  }

  private func locationReached() {
    WalkCoordinate.clearCurrent()
    WalkCircleMonitor.stop()
    WalkUserDefaults.anyCircleReached.save(true)
    WalkCirlesReachedToday.increment()
    WalkNotification.showNow("You reached your circle. Congrats!")
    WalkViewControllers.Congrats.show()
  }

  private class func createRegion(coordinate: CLLocationCoordinate2D) -> CLCircularRegion {
    return CLCircularRegion(center: coordinate, radius: WalkConstants.regionCircleRadiusMeters,
      identifier: "walk circle")
  }
}
