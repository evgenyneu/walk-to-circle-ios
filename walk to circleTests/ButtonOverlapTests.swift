//
//  ButtonOverlapTests.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 10/08/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import XCTest

class ButtonOverlapTests: XCTestCase {

  let obj = ButtonOverlap()

  func testDeltaCorrection() {
    let buttonRect = CGRect(x: 100, y: 100, width: 50, height: 50)
    let point = CGPoint(x: 114, y: 123)
    let delta = CGSize(width: 10, height: 10)

    let result = obj.scollCorrection(delta, buttonRect: buttonRect, pinCoordinate: point)

    XCTAssertEqual(10, result.width)
    XCTAssertEqual(43, result.height)

  }

  func testVerticalCorrection() {
    let rect = CGRect(x: 100, y: 100, width: 50, height: 50)
    let point = CGPoint(x: 110, y: 130)

    let result = obj.verticalCorrection(rect, pinCoordinate: point)
    XCTAssertEqual(-50, result)
  }

  func testButtonOverlapsPin_YES() {
    let rect = CGRect(x: 100, y: 100, width: 50, height: 50)
    let point = CGPoint(x: 110, y: 130)
    
    let result = obj.buttonOverlapsPin(rect, pinCoordinate: point)

    XCTAssertTrue(result)
  }

  func testButtonOverlapsPin_NO() {
    let rect = CGRect(x: 100, y: 100, width: 50, height: 50)
    let point = CGPoint(x: 160, y: 130)

    let result = obj.buttonOverlapsPin(rect, pinCoordinate: point)

    XCTAssertFalse(result)
  }
}
