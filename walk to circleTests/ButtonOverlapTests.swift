//
//  ButtonOverlapTests.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 10/08/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import XCTest
@testable import WalkToCircle

class ButtonOverlapTests: XCTestCase {

  let obj = ButtonOverlap()

  func testDeltaCorrection() {
    let buttonRect = CGRect(x: 100, y: 100, width: 50, height: 50)
    let point = CGPoint(x: 114, y: 123)
    let delta = CGSize(width: 10, height: 10)

    let result = obj.scollCorrection(delta, buttonRect: buttonRect, pinCoordinate: point,
      scrollToRightOnHorizontalCorrection: true)

    XCTAssertEqual(CGFloat(10), result.width)
    XCTAssertEqual(CGFloat(43), result.height)
  }

  // scollCorrection
  // --------------------------

  func testVerticalCorrection_correctVeritically() {
    let rect = CGRect(x: 100, y: 100, width: 50, height: 50)
    let point = CGPoint(x: 110, y: 130)

    let result = obj.scollCorrection(rect, pinCoordinate: point,
      scrollToRightOnHorizontalCorrection: false)

    XCTAssertEqual(CGFloat(0), result.width)
    XCTAssertEqual(CGFloat(-50), result.height)
  }

  func testVerticalCorrection_correctHorizontally_left() {
    let rect = CGRect(x: 200, y: 200, width: 50, height: 50)
    let point = CGPoint(x: 210, y: 230)

    let result = obj.scollCorrection(rect, pinCoordinate: point,
      scrollToRightOnHorizontalCorrection: false)

    XCTAssertEqual(CGFloat(-110), result.width)
    XCTAssertEqual(CGFloat(0), result.height)
  }

  func testVerticalCorrection_correctHorizontally_right() {
    let rect = CGRect(x: 200, y: 200, width: 50, height: 50)
    let point = CGPoint(x: 210, y: 230)

    let result = obj.scollCorrection(rect, pinCoordinate: point,
      scrollToRightOnHorizontalCorrection: true)

    XCTAssertEqual(CGFloat(140), result.width)
    XCTAssertEqual(CGFloat(0), result.height)
  }

  // buttonOverlapsPin
  // --------------------------

  func testButtonOverlapsPin_YES() {
    let rect = CGRect(x: 100, y: 100, width: 50, height: 50)
    let point = CGPoint(x: 110, y: 130)
    
    let result = obj.buttonOverlapsPin(rect, pinCoordinate: point)

    XCTAssertTrue(result)
  }

  func testButtonOverlapsPin_NO() {
    let rect = CGRect(x: 100, y: 100, width: 50, height: 50)
    let point = CGPoint(x: 240, y: 170)

    let result = obj.buttonOverlapsPin(rect, pinCoordinate: point)

    XCTAssertFalse(result)
  }
}
