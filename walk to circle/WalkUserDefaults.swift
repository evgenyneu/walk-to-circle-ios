//
//  WalkUserDefaults.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 22/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

enum WalkUserDefaults: String {
  case currentViewControllerId = "current view controller name"
  case currentNonErrorViewControllerId = "current non error view controller name"

  case currentCircleCoordinateLatitude = "current circle coordinate latitude"
  case currentCircleCoordinateLongitude = "current circle coordinate longitude"

  case anyCircleReached = "circle reached"

  var value: AnyObject? {
    get {
      let userDefaults = NSUserDefaults.standardUserDefaults()
      return userDefaults.valueForKey(self.rawValue)
    }
  }

  func save(value: AnyObject?) {
    let userDefaults = NSUserDefaults.standardUserDefaults()

    if let currentValue: AnyObject = value {
      userDefaults.setValue(value, forKey: self.rawValue)
    } else {
      userDefaults.removeObjectForKey(self.rawValue)
    }
    
    userDefaults.synchronize()
  }

  func boolValue(defaultValue: Bool = false) -> Bool {
    if let boolValue = value as? Bool {
      return boolValue
    }

    return defaultValue
  }
}