//
//  scrollToAnnotationTests.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 10/08/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import XCTest
@testable import WalkToCircle

class scrollToAnnotationTests: XCTestCase {
  func testGetScroll_NoScroll() {
    let mapSize = CGSize(width: 300, height: 500)
    let annotationCoordinate = CGPoint(x: 100, y: 400)
    let result = ScrollToAnnotation.getScroll(mapSize, annotationCoordinate: annotationCoordinate)

    XCTAssertEqual(CGFloat(0), result.width)
    XCTAssertEqual(CGFloat(0), result.height)
  }

  func testGetScroll_Positive() {
    let mapSize = CGSize(width: 300, height: 500)
    let annotationCoordinate = CGPoint(x: 378, y: 514)
    let result = ScrollToAnnotation.getScroll(mapSize, annotationCoordinate: annotationCoordinate)

    XCTAssertEqual(CGFloat(128), result.width)
    XCTAssertEqual(CGFloat(64), result.height)
  }

  func testGetScroll_Negative() {
    let mapSize = CGSize(width: 300, height: 500)
    let annotationCoordinate = CGPoint(x: -11, y: -43)
    let result = ScrollToAnnotation.getScroll(mapSize, annotationCoordinate: annotationCoordinate)

    XCTAssertEqual(CGFloat(-61), result.width)
    XCTAssertEqual(CGFloat(-168), result.height)
  }
}
