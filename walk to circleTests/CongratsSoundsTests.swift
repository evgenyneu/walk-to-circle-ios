//
//  CongratsSoundsTests.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 1/01/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

import UIKit
import WalkToCircle
import XCTest

class CongratsSoundsTests: XCTestCase {
  func testGetFileName() {
    XCTAssertEqual("applause_1.mp3", CongratsSounds.getFileName(1))
    XCTAssertEqual("applause_2.mp3", CongratsSounds.getFileName(2))
    XCTAssertEqual("applause_3.mp3", CongratsSounds.getFileName(3))
    XCTAssertEqual("applause_4.mp3", CongratsSounds.getFileName(5))
    XCTAssertEqual("applause_7.mp3", CongratsSounds.getFileName(7))
    XCTAssertEqual("applause_9.mp3", CongratsSounds.getFileName(9))
    XCTAssertEqual("applause_12.mp3", CongratsSounds.getFileName(14))
    XCTAssertEqual("applause_20.mp3", CongratsSounds.getFileName(20))

    // Edge cases

    XCTAssertEqual("applause_1.mp3", CongratsSounds.getFileName(-1))
    XCTAssertEqual("applause_1.mp3", CongratsSounds.getFileName(0))
    XCTAssertEqual("applause_20.mp3", CongratsSounds.getFileName(1232))
  }
}
