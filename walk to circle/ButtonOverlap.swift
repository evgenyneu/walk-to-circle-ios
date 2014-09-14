//
//  ButtonOverlap.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 10/08/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class ButtonOverlap {
  // Returns vertical offest in pixels to prevent button from ovelaping with the pin
  func verticalCorrection(buttonRect: CGRect, pinCoordinate: CGPoint) -> CGFloat {
    if buttonOverlapsPin(buttonRect, pinCoordinate: pinCoordinate) {
      let offset = buttonRect.origin.y - pinCoordinate.y - 20

      if offset < 0 { return CGFloat(offset); }
    }

    return 0;
  }

  // Returns true if annotation overlaps with the button
  func buttonOverlapsPin(buttonRect: CGRect, pinCoordinate: CGPoint) -> Bool {
    let rectExpanded = CGRect(
      x: (buttonRect.origin.x - 10),
      y: buttonRect.origin.y,
      width: buttonRect.size.width + 20,
      height: buttonRect.size.height + 50)

    return rectExpanded.contains(pinCoordinate)
  }
}