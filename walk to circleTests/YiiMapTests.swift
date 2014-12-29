//
//  YiiMapTests.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 29/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

import UIKit
import WalkToCircle
import XCTest

class YiiMapTests: XCTestCase {

  func testMinMaxCircleDistance() {
    let (minDistance, maxDistance) = YiiMap.minMaxCircleDistance
    XCTAssertEqual(280, minDistance)
    XCTAssertEqual(520, maxDistance)
  }
}