//
//  WalkTutorial.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 3/01/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

class WalkTutorial {
  class var showTutorial: Bool {
    // show tutorial screen if user has not reached any circles yet
    return !WalkUserDefaults.anyCircleReached.boolValue()
  }
}
