//
//  YiiQuotes.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 24/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import WalkToCircle
import XCTest

class YiiQuotesTests: XCTestCase {
  func testShowRandomQuote() {
    let expectation = expectationWithDescription("quote is shown")

    let obj = YiiQuotes()

    let textLabel = UILabel()
    obj.textLabel = textLabel

    let authorLabel = UILabel()
    obj.authorLabel = authorLabel

    obj.showRandomQuote {
      XCTAssertEqual(false, textLabel.text!.isEmpty)
      XCTAssertEqual(false, authorLabel.text!.isEmpty)

      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(0.05, handler: nil)
  }

  func testPickRandomQuote() {
    let quotes = [
      WalkQuote(text: "text 1", author: "author 1")
    ]

    let quote = YiiQuotes.pickRandomQuote(quotes)!

    XCTAssertEqual("text 1", quote.text)
    XCTAssertEqual("author 1", quote.author)
  }

  func testPickRandomQuote_edgeCases() {
    XCTAssertTrue(YiiQuotes.pickRandomQuote([]) == nil)
  }
}
