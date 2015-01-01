//
//  Loads quotes from a text file.
//
//  Created by Evgenii Neumerzhitckii on 24/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public class WalkQuotesLoader {
  private var isLoading = false
  private var loadedQuotes: [WalkQuote]?
  private var loadingCallbacks = Array<([WalkQuote])->()>()

  public init() { }

  public class func load(json: String) -> [WalkQuote] {

    let p = CutePossumParser(json: json)

    return p.parseArray([], parser: { p in
      
      return WalkQuote(
        text: p.parse("text",miss: ""),
        author:  p.parse("author",miss: ""))

    }) as [WalkQuote]
  }


  public func loadQuotes(callback: ([WalkQuote])->()) {
    if let currentLoadedQuotes = loadedQuotes {
      callback(currentLoadedQuotes)
      return
    }

    loadingCallbacks.append(callback)

    if isLoading { return }
    isLoading = true

    iiQ.async {
      if let json = iiJsonLoader.read(WalkConstants.quotesJsonFileName) {
        let quotes = WalkQuotesLoader.load(json)

        iiQ.main {

          self.loadedQuotes = quotes

          for callback in self.loadingCallbacks {
            callback(quotes)
          }

          self.loadingCallbacks = []
          self.isLoading = false
        }
      }
    }
  }
}
