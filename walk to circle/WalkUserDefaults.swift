//
//  WalkUserDefaults.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 22/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

public enum WalkUserDefaults: String {
  // String. ID of the current view controller.
  case currentViewControllerId = "current view controller name"

  // String. ID of the current non-error view controller (like Map, Walk or Congrats screen.)
  case currentNonErrorViewControllerId = "current non error view controller name"

  // Double. Latitude and logintude of the current circle.
  // Do not use it directly. Use WalkCoordinate.current to get/set current circle location instead.
  case currentCircleCoordinateLatitude = "current circle coordinate latitude"
  case currentCircleCoordinateLongitude = "current circle coordinate longitude"

  // Double. Latitude and logintude of the previous circle.
  // Do not use it directly. Use WalkCoordinate.previous to get/set previous circle location instead.
  case previousCircleCoordinateLatitude = "previous circle coordinate latitude"
  case previousCircleCoordinateLongitude = "previous circle coordinate longitude"

  // Integer. Contains number of circles reached so far.
  // It is used to get the number fo circles reached today.
  //
  // Important:
  //   Do not use it directly.
  //   Use WalkCirlesReachedToday instead to get/set number of circles reached today.
  //
  case circlesReached = "circles reached today"

  // String. Date when last circle was reached. Format: "yyyy.mm.dd" format. Example: "2017.12.26".
  case lastCircleReachedDate_yearMonthDay = "last circle reached date - year, month, day"

  // Bool. True if user has ever reached a circle.
  // It is used to decide if we need to show tutorial messages.
  case anyCircleReached = "circle reached"

  public var value: AnyObject? {
    get {
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.valueForKey(self.rawValue)
    }
  }

  public func save(value: AnyObject?) {
    let userDefaults = NSUserDefaults.standardUserDefaults()

    if value != nil {
      userDefaults.setValue(value, forKey: self.rawValue)
    } else {
      userDefaults.removeObjectForKey(self.rawValue)
    }
    
    userDefaults.synchronize()
  }

  public func clear() {
    save(nil)
  }

  public func boolValue(defaultValue: Bool = false) -> Bool {
    if let boolValue = value as? Bool {
      return boolValue
    }

    return defaultValue
  }

  public func intValue(defaultValue: Int) -> Int {
    if let intValue = value as? Int {
      return intValue
    }

    return defaultValue
  }

  public func stringValue(defaultValue: String = "") -> String {
    if let strValue = value as? String {
      return strValue
    }

    return defaultValue
  }
}