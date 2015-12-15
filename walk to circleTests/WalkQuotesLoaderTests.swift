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

    XCTAssertEqual(31, quotes.count)

    // First quote
    // ---------

    let quote = quotes.first!

    XCTAssertEqual("Scientific studies have shown that walking, besides its physical benefits, is also beneficial for the mind, improving memory skills, learning ability, concentration and abstract reasoning, as well as reducing stress and lifting spirits.",
      quote.text)
    
    XCTAssertEqual("Wikipedia", quote.author)
  }

  func testLoadQuotes() {
    let expectation = expectationWithDescription("Loads quotes")

    obj.loadQuotes({ quotes in
      XCTAssertEqual(31, quotes.count)
      XCTAssertEqual("Wikipedia", quotes[0].author)

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

    XCTAssertEqual(31, addedQuotes[0].count)
    XCTAssertEqual("Wikipedia", addedQuotes[0][0].author)
  }
}
