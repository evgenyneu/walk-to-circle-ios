//
//  WalkQuotePickerTests.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 1/01/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import WalkToCircle
import XCTest

class WalkQuotePickerTests: XCTestCase {
  func testGetUnseenQuotesToday() {
    let allQuotes = [
      WalkQuote(text: "one", author: "one"),
      WalkQuote(text: "two", author: "two"),
      WalkQuote(text: "three", author: "three")
    ]

    let seenQuotes = ["two"]

    let quotes = WalkQuotePicker.unseenQuotesToday(allQuotes, alreadySeenToday: seenQuotes)

    XCTAssertEqual(2, quotes.count)

    XCTAssertEqual("one", quotes[0].text)
    XCTAssertEqual("three", quotes[1].text)
  }

  func testGetUnseenQuotesToday_fromGlobalUbseenArray() {
    let allQuotes = [
      WalkQuote(text: "one", author: "one"),
      WalkQuote(text: "two", author: "two"),
      WalkQuote(text: "three", author: "three")
    ]

    walkQuotesSeenToday = ["three", "one"]

    let quotes = WalkQuotePicker.unseenQuotesToday(allQuotes)

    XCTAssertEqual(1, quotes.count)
    XCTAssertEqual("two", quotes[0].text)
  }
}
