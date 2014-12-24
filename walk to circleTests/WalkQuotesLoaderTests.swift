//
//  WalkQuoteLoaderTests.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 24/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import WalkToCircle
import XCTest

class WalkQuotesLoaderTests: XCTestCase {
  func testLoadQuotes() {
    let json = iiJsonLoader.read(WalkConstants.quotesJsonFileName)
    let quotes = WalkQuotesLoader.load(json!)

    XCTAssertEqual(2, quotes.count)

    // First quote
    // ---------

    let quote = quotes.first!

    XCTAssertEqual("An early-morning walk is a blessing for the whole day.",
      quote.text)
    
    XCTAssertEqual("Henry David Thoreau", quote.author)

    // Last quote
    // ---------

    let lastQuote = quotes.last!

    XCTAssertEqual("My life is like a stroll upon the beach,\nAs near the ocean's edge as I can go.",
      lastQuote.text)

    XCTAssertEqual("Henry David Thoreau", lastQuote.author)
  }
}
