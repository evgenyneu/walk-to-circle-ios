//
//  WalkCirlesReachedToday.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 30/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public class WalkCirlesReachedToday {
  public class func increment() {
    let current = WalkUserDefaults.circlesReachedToday.intValue(0)
    WalkUserDefaults.circlesReachedToday.save(current + 1)
  }

  public class var number: Int {
    return WalkUserDefaults.circlesReachedToday.intValue(0)
  }
}
