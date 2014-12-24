//
//  YiiQuotes.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 24/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class YiiQuotes: NSObject {

  @IBOutlet weak var quoteTextLabel: UILabel!
  @IBOutlet weak var quoteAuthorLabel: UILabel!

  func showRandomQuote() {
  }

  private var loadedQuotes: [WalkQuote]?

  
}
