//
//  WalkQuotePicker.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 1/01/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public var walkQuotesSeenToday = [String]()

public class WalkQuotePicker {
  public class func unseenQuotesToday(allQuotes: [WalkQuote]) -> [WalkQuote] {
    return unseenQuotesToday(allQuotes, alreadySeenToday: walkQuotesSeenToday)
  }

  public class func unseenQuotesToday(allQuotes: [WalkQuote],
    alreadySeenToday: [String]) -> [WalkQuote] {

    return allQuotes.filter { quote in
      return !contains(alreadySeenToday, quote.text)
    }
  }
}