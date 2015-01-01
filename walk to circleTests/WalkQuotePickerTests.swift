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

  // unseenQuotesToday
  // -----------------

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

  func testGetUnseenQuotesToday_fromGlobalUbseenArray_whenAllQuotesAreSeen_EmptyUnseenArray() {
    let allQuotes = [
      WalkQuote(text: "one", author: "one"),
      WalkQuote(text: "two", author: "two"),
      WalkQuote(text: "three", author: "three")
    ]

    walkQuotesSeenToday = ["three", "one", "two"]

    let quotes = WalkQuotePicker.unseenQuotesToday(allQuotes)

    XCTAssertEqual(true, walkQuotesSeenToday.isEmpty)

    XCTAssertEqual(3, quotes.count)
    XCTAssertEqual("one", quotes[0].text)
  }

  // random
  // -----------------

  func testPickRandomQuote() {
    let allQuotes = [WalkQuote(text: "Hi, I am Mastodon", author: "Mastodon")]

    let quote = WalkQuotePicker.random(allQuotes)!

    XCTAssertEqual("Hi, I am Mastodon", quote.text)
  }

  func testPickRandomQuote_addQuoteToListOfSeenQuotesToday() {
    let allQuotes = [WalkQuote(text: "Hi, I am great auk", author: "Mastodon")]

    walkQuotesSeenToday = []

    WalkQuotePicker.random(allQuotes)

    XCTAssertEqual(1, walkQuotesSeenToday.count)
    XCTAssertEqual("Hi, I am great auk", walkQuotesSeenToday[0])
  }

  func testPickRandomQuote_adsToUnseeQuotesListOnlyOnce() {
    let allQuotes = [WalkQuote(text: "Hi, I am great auk", author: "Mastodon")]

    walkQuotesSeenToday = []

    WalkQuotePicker.random(allQuotes)
    WalkQuotePicker.random(allQuotes)
    WalkQuotePicker.random(allQuotes)

    XCTAssertEqual(1, walkQuotesSeenToday.count)
    XCTAssertEqual("Hi, I am great auk", walkQuotesSeenToday[0])
  }
}
