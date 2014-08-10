//
//  scrollToAnnotationTests.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 10/08/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import XCTest

class scrollToAnnotationTests: XCTestCase {

  let obj = ScrollToAnnotation()

  func testGetScroll_NoScroll() {
    let mapSize = CGSize(width: 300, height: 500)
    let annotationCoordinate = CGPoint(x: 100, y: 400)
    var result = obj.getScroll(mapSize, annotationCoordinate: annotationCoordinate)

    XCTAssertEqual(0, result.width)
    XCTAssertEqual(0, result.height)
  }

  func testGetScroll_Positive() {
    let mapSize = CGSize(width: 300, height: 500)
    let annotationCoordinate = CGPoint(x: 378, y: 514)
    var result = obj.getScroll(mapSize, annotationCoordinate: annotationCoordinate)

    XCTAssertEqual(98, result.width)
    XCTAssertEqual(34, result.height)
  }

  func testGetScroll_Negative() {
    let mapSize = CGSize(width: 300, height: 500)
    let annotationCoordinate = CGPoint(x: -11, y: -43)
    var result = obj.getScroll(mapSize, annotationCoordinate: annotationCoordinate)

    XCTAssertEqual(-31, result.width)
    XCTAssertEqual(-113, result.height)
  }
}
