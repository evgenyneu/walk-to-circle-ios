//
//  iiScreen.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 25/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

let iiScreenSizeBounds = UIScreen.mainScreen().bounds

class iiScreenSize {
  class var minSide: CGFloat {
    let screenSize = iiScreenSizeBounds.size
    return min(screenSize.width, screenSize.height)
  }

  class var maxSide: CGFloat {
    let screenSize = iiScreenSizeBounds.size
    return max(screenSize.width, screenSize.height)
  }
}
