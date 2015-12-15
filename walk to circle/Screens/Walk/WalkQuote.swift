//
//  WalkQuote.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 24/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct WalkQuote {
  public init(text: String, author: String) {
    self.text = text
    self.author = author
  }

  public let text: String
  public let author: String
}
