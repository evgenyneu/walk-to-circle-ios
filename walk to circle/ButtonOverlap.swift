//
//  ButtonOverlap.swift
//  
//  Prevent placing pin over button
//
//  Created by Evgenii Neumerzhitckii on 10/08/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class ButtonOverlap {

  // Returns the amount of scrolling needed for the map view
  // to prevent `pinCoordinate` from overlaping with `buttonRect`.
  // `delta` is the current scoll correction of the map view.
  func scollCorrection(currentScrollCorrection: CGSize,
    buttonRect: CGRect, pinCoordinate: CGPoint) -> CGSize {

    var resultCorrection = currentScrollCorrection

    let coordinateCorrected = CGPoint(
      x: pinCoordinate.x - currentScrollCorrection.width,
      y: pinCoordinate.y - currentScrollCorrection.height)

    let vericalCorrection = verticalCorrection(buttonRect, pinCoordinate: coordinateCorrected)

    if vericalCorrection != 0 {
      resultCorrection.height -= vericalCorrection
      println("Button overlap detected! \(vericalCorrection)")
    }

    return resultCorrection
  }

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