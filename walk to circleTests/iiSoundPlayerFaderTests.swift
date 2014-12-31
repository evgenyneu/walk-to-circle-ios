//
//  iiSoundPlayerFader.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 31/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import WalkToCircle
import XCTest

class iiSoundPlayerFaderTests: XCTestCase {

  // volumeMultiplier
  // -------------------

  func testTimeValueNormalized() {
    XCTAssertEqual(1.000, rounded(iiSoundPlayerFader.volumeMultiplier(0,   velocity: 5)))
    XCTAssertEqual(0.607, rounded(iiSoundPlayerFader.volumeMultiplier(0.1, velocity: 5)))
    XCTAssertEqual(0.082, rounded(iiSoundPlayerFader.volumeMultiplier(0.5, velocity: 5)))
    XCTAssertEqual(0.018, rounded(iiSoundPlayerFader.volumeMultiplier(0.8, velocity: 5)))
    XCTAssertEqual(0.011, rounded(iiSoundPlayerFader.volumeMultiplier(0.9, velocity: 5)))
    XCTAssertEqual(0.007, rounded(iiSoundPlayerFader.volumeMultiplier(1,   velocity: 5)))

    //edge cases
    XCTAssertEqual(1.000, rounded(iiSoundPlayerFader.volumeMultiplier(-12,   velocity: 5)))
    XCTAssertEqual(0.007, rounded(iiSoundPlayerFader.volumeMultiplier(123,   velocity: 5)))
  }

  func testTimeValueNormalized_withDifferentVelocity() {
    XCTAssertEqual(0.007, rounded(iiSoundPlayerFader.volumeMultiplier(0.5, velocity: 10)))
  }

  // volumeMultiplier
  // -------------------

  func testTimeValue() {
    // 0%
    var result = iiSoundPlayerFader.timeFrom0To1(0, fadeIntervalSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(0.0, rounded(result))

    // 10%
    result = iiSoundPlayerFader.timeFrom0To1(1, fadeIntervalSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(0.1, rounded(result))

    result = iiSoundPlayerFader.timeFrom0To1(2, fadeIntervalSeconds: 2, stepsPerSecond: 10)
    XCTAssertEqual(0.1, rounded(result))

    result = iiSoundPlayerFader.timeFrom0To1(4, fadeIntervalSeconds: 2, stepsPerSecond: 20)
    XCTAssertEqual(0.1, rounded(result))

    // 50%
    result = iiSoundPlayerFader.timeFrom0To1(5, fadeIntervalSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(0.5, rounded(result))

    // 100%
    result = iiSoundPlayerFader.timeFrom0To1(10, fadeIntervalSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(1.0, rounded(result))

    // Edge cases
    // -----------------

    result = iiSoundPlayerFader.timeFrom0To1(-10, fadeIntervalSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(0.0, rounded(result))

    result = iiSoundPlayerFader.timeFrom0To1(100, fadeIntervalSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(1.0, rounded(result))

    result = iiSoundPlayerFader.timeFrom0To1(1, fadeIntervalSeconds: 0, stepsPerSecond: 10)
    XCTAssertEqual(1.0, rounded(result))

    result = iiSoundPlayerFader.timeFrom0To1(1, fadeIntervalSeconds: 1, stepsPerSecond: 0)
    XCTAssertEqual(1.0, rounded(result))
  }

  private func rounded(value: Double) -> Double {
    let decimalDigits = 3.0
    let miltiplier = pow(10.0, decimalDigits)
    return round(value * miltiplier) / miltiplier
  }
}