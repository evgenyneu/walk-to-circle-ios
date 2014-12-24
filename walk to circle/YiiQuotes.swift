//
//  YiiQuotes.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 24/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

public class YiiQuotes: NSObject {

  @IBOutlet public weak var textLabel: UILabel!
  @IBOutlet public weak var authorLabel: UILabel!

  private let quotesLoader = WalkQuotesLoader()

  func setup() {
    textLabel.text = ""
    authorLabel.text = ""
  }

  public func showRandomQuote(finished: (()->())? = nil) {

    quotesLoader.loadQuotes({ quotes in
      if let quote = YiiQuotes.pickRandomQuote(quotes) {
        YiiQuotes.showRandomQuote(quote, textLabel: self.textLabel, authorLabel: self.authorLabel)
        finished?()
      }
    })
  }

  public class func pickRandomQuote(quotes: [WalkQuote]) -> WalkQuote? {
    if quotes.isEmpty { return nil }
    let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
    return quotes[randomIndex]
  }

  private class func showRandomQuote(quote: WalkQuote,
    textLabel: UILabel, authorLabel:UILabel) {

    textLabel.text = quote.text
    authorLabel.text = quote.author
  }
}
