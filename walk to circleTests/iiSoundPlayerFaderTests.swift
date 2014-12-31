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
  func testTimeValue() {
    XCTAssertEqual(1.000, rounded(iiSoundPlayerFader.timeValue(0,   velocity: 5.0)))
    XCTAssertEqual(0.607, rounded(iiSoundPlayerFader.timeValue(0.1, velocity: 5.0)))
    XCTAssertEqual(0.082, rounded(iiSoundPlayerFader.timeValue(0.5, velocity: 5.0)))
    XCTAssertEqual(0.018, rounded(iiSoundPlayerFader.timeValue(0.8, velocity: 5.0)))
    XCTAssertEqual(0.011, rounded(iiSoundPlayerFader.timeValue(0.9, velocity: 5.0)))
    XCTAssertEqual(0.007, rounded(iiSoundPlayerFader.timeValue(1,   velocity: 5.0)))

    //edge cases
    XCTAssertEqual(1.000, rounded(iiSoundPlayerFader.timeValue(-12,   velocity: 5.0)))
    XCTAssertEqual(0.007, rounded(iiSoundPlayerFader.timeValue(123,   velocity: 5.0)))
  }

  func testTimeValue_withDifferentVelocity() {
    XCTAssertEqual(0.007, rounded(iiSoundPlayerFader.timeValue(0.5, velocity: 10.0)))
  }

  private func rounded(value: Double) -> Double {
    let decimalDigits = 3.0
    let miltiplier = pow(10.0, decimalDigits)
    return round(value * miltiplier) / miltiplier
  }
}