//
//  WalkQuotesLoader.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 24/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public class WalkQuotesLoader {
  public class func load(json: String) -> [WalkQuote] {

    let p = CutePossumParser(json: json)

    return p.parseArray([], parser: { p in
      
      return WalkQuote(
        text: p.parse("text",miss: ""),
        author:  p.parse("author",miss: ""))

    }) as [WalkQuote]
  }
}
