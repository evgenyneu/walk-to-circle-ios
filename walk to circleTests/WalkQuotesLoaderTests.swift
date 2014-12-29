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
  let obj = WalkQuotesLoader()
  
  func testLoadQuotesFromFile() {
    let json = iiJsonLoader.read(WalkConstants.quotesJsonFileName)
    let quotes = WalkQuotesLoader.load(json!)

    XCTAssertEqual(32, quotes.count)

    // First quote
    // ---------

    let quote = quotes.first!

    XCTAssertEqual("There are many dumb ways to die. One of them is to be hit by a car while using this app. Please be alert around cars.",
      quote.text)
    
    XCTAssertEqual("Evgenii Neumerzhitckii", quote.author)
  }

  func testLoadQuotes() {
    let expectation = expectationWithDescription("Loads quotes")

    obj.loadQuotes({ quotes in
      XCTAssertEqual(32, quotes.count)
      XCTAssertEqual("Evgenii Neumerzhitckii", quotes[0].author)

      expectation.fulfill()
    })

    var addedQuotes = [[WalkQuote]]()

    // Subscribe to quotes again asynchronously
    obj.loadQuotes({ quotes in addedQuotes.append(quotes) })

    waitForExpectationsWithTimeout(0.05, handler: nil)

    // Return quotes synchronously the second time
    // -------------------

    obj.loadQuotes({ quotes in addedQuotes.append(quotes) })

    XCTAssertEqual(2, addedQuotes.count)

    XCTAssertEqual(32, addedQuotes[0].count)
    XCTAssertEqual("Evgenii Neumerzhitckii", addedQuotes[0][0].author)
  }
}
