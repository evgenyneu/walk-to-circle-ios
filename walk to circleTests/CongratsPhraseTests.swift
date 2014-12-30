//
//  CongratsPhraseTests.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 30/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import WalkToCircle
import XCTest

class CongratsPhraseTests: XCTestCase {

  func testGetRandom() {
    walkCongratsPhrases[1] = ["Test one"]
    XCTAssertEqual("asdajkj", CongratsPhrase.random(1))
  }

  func testGetPhrases() {
    walkCongratsPhrases[1] = ["Test one"]
    walkCongratsPhrases[2] = ["Test two"]
    walkCongratsPhrases[5] = ["Test five"]
    walkCongratsPhrases[8] = ["Test eight"]
    walkCongratsPhrases[13] = ["Test 13"]
    walkCongratsPhrases[20] = ["Test Oh My Glob!"]

    var result = CongratsPhrase.getPhrases(1)
    XCTAssertEqual(["Test one"], result)

    result = CongratsPhrase.getPhrases(2)
    XCTAssertEqual(["Test two"], result)

    result = CongratsPhrase.getPhrases(3)
    XCTAssertEqual(["Test two"], result)

    result = CongratsPhrase.getPhrases(5)
    XCTAssertEqual(["Test five"], result)

    result = CongratsPhrase.getPhrases(12)
    XCTAssertEqual(["Test eight"], result)

    result = CongratsPhrase.getPhrases(21)
    XCTAssertEqual(["Test Oh My Glob!"], result)

    // Edge cases
    result = CongratsPhrase.getPhrases(0)
    XCTAssertEqual(["Test one"], result)

    result = CongratsPhrase.getPhrases(123123)
    XCTAssertEqual(["Test Oh My Glob!"], result)

    result = CongratsPhrase.getPhrases(-123123)
    XCTAssertEqual(["Test one"], result)
  }

  func testUnseenPhrasesToday() {
    let result = CongratsPhrase.unseenPhrasesToday(["a", "b", "c"], alreadySeenToday: ["a"])
    XCTAssertEqual(["b", "c"], result)
  }

  func testUnseenPhrasesToday_withGlobalPhrases() {
    walkCongratsPhrasesSeenToday = ["b"]
    let result = CongratsPhrase.unseenPhrasesToday(["a", "b", "c"])
    XCTAssertEqual(["a", "c"], result)
  }

  func testUnseenPhrasesToday_withGlobalPhrases_whenAllSeen() {
    walkCongratsPhrasesSeenToday = ["b", "c", "a"]

    let result = CongratsPhrase.unseenPhrasesToday(["a", "b", "c"])

    XCTAssertEqual(["a", "b", "c"], result)
    XCTAssertEqual([], walkCongratsPhrasesSeenToday)
  }

}