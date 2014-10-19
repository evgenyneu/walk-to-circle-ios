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
  //
  // Parameters:
  //
  //    delta: current scoll correction of the map view.
  //    scrollToRightOnHorizontalCorrection: scroll to the right when horizontal scrolling is needed
  //
  func scollCorrection(delta: CGSize,
    buttonRect: CGRect, pinCoordinate: CGPoint,
    scrollToRightOnHorizontalCorrection: Bool) -> CGSize {

    var resultCorrection = delta

    let coordinateCorrected = CGPoint(
      x: pinCoordinate.x - delta.width,
      y: pinCoordinate.y - delta.height)

    let correction = scollCorrection(buttonRect, pinCoordinate: coordinateCorrected,
        scrollToRightOnHorizontalCorrection: scrollToRightOnHorizontalCorrection)

    resultCorrection.width -= correction.width
    resultCorrection.height -= correction.height

    return resultCorrection
  }

  // Returns the amount of scrolling needed for the map view
  // to prevent `pinCoordinate` from overlaping with `buttonRect`.
  //
  // Parameters:
  //
  //    scrollToRightOnHorizontalCorrection: scroll to the right when horizontal scrolling is needed
  //
  func scollCorrection(buttonRect: CGRect, pinCoordinate: CGPoint,
    scrollToRightOnHorizontalCorrection: Bool) -> CGSize {

    var correction = CGSize()

    if buttonOverlapsPin(buttonRect, pinCoordinate: pinCoordinate) {

      if buttonRect.origin.x >= 200 {
        // correct horizontally
        if scrollToRightOnHorizontalCorrection {
          correction.width = buttonRect.maxX - pinCoordinate.x + 100
        } else {
          correction.width = buttonRect.origin.x - pinCoordinate.x - 100
        }
      } else {
        // correct vertically
        correction.height = buttonRect.origin.y - pinCoordinate.y - 20
      }
      
    }

    return correction
  }

  // Returns true if annotation overlaps with the button
  func buttonOverlapsPin(buttonRect: CGRect, pinCoordinate: CGPoint) -> Bool {
    let rectExpanded = CGRect(
      x: (buttonRect.origin.x - 80),
      y: buttonRect.origin.y,
      width: buttonRect.size.width + 160,
      height: buttonRect.size.height + 50)

    return rectExpanded.contains(pinCoordinate)
  }
}