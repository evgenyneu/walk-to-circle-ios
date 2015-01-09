//
//  Picks a random quote. Make sure one does not see the same quote twice on the same day
//  unless seen all quotes.
//
//  Created by Evgenii Neumerzhitckii on 1/01/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public var walkQuotesSeenToday = [String]()

public class WalkQuotePicker {
  public class func random(quotes: [WalkQuote]) -> WalkQuote? {
    let unseenQuotes = unseenQuotesToday(quotes)
    
    if let currentQuote = iiRandom.random(unseenQuotes) {

      if !contains(walkQuotesSeenToday, currentQuote.text) {
        walkQuotesSeenToday.append(currentQuote.text)
      }

      return currentQuote
    }

    return nil
  }

  public class func unseenQuotesToday(allQuotes: [WalkQuote]) -> [WalkQuote] {
    var unseenQuotes = unseenQuotesToday(allQuotes, alreadySeenToday: walkQuotesSeenToday)

    if unseenQuotes.isEmpty {
      // Seen all quotes today. Reset the seen array.
      walkQuotesSeenToday = []
      unseenQuotes = allQuotes
    }

    return unseenQuotes
  }

  public class func unseenQuotesToday(allQuotes: [WalkQuote],
    alreadySeenToday: [String]) -> [WalkQuote] {

    return allQuotes.filter { quote in
      return !contains(alreadySeenToday, quote.text)
    }
  }
}