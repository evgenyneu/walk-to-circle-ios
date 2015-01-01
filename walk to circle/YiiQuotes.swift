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
  @IBOutlet weak var scrollView: UIScrollView!
  
  private let quotesLoader = WalkQuotesLoader()

  func setup() {
    textLabel.text = ""
    authorLabel.text = ""
    scrollView.hidden = true

    TegScrolledContent.createContentView(scrollView)
  }

  public func showRandomQuote(onFinished: (()->())? = nil) {
    if YiiQuotes.showTutorial {
      let tutorial = WalkQuote(text: WalkConstants.tutorialText, author: WalkConstants.tutorialAuthor)
      YiiQuotes.showQuote(tutorial, textLabel: textLabel, authorLabel: authorLabel)
      return
    }

    quotesLoader.loadQuotes({ quotes in
      if let quote = WalkQuotePicker.random(quotes) {
        YiiQuotes.showQuote(quote, textLabel: self.textLabel, authorLabel: self.authorLabel)
        onFinished?() // used in test
      }
    })
  }

  private class var showTutorial: Bool {
    // show tutorial screen if user has not reached any circles yet
    return !WalkUserDefaults.anyCircleReached.boolValue()
  }

  private class func showQuote(quote: WalkQuote,
    textLabel: UILabel, authorLabel:UILabel) {

    textLabel.text = quote.text
    authorLabel.text = quote.author
  }

  func show() {
    if !scrollView.hidden { return } // already shown
    scrollView.hidden = false
    iiAnimator.fadeInSpring(scrollView, duration: WalkConstants.textFadeInDuration)
  }

  func adjustToNewSize(orientation: UIInterfaceOrientation) {
    var verticalCompact = false

    if UIInterfaceOrientationIsLandscape(orientation) && iiScreenSize.minSide < 600 {
      // No top margin when in landscape and screen height is small (phones in landscape)
      verticalCompact = true
    }

    adjustToNewSize(verticalCompact)
  }
  
  private func adjustToNewSize(verticalCompact: Bool) {
    if verticalCompact {
      scrollView.contentInset.top = WalkConstants.quotesTopMarginCompact
    } else {
      let topMargin = WalkConstants.quotesTopMargin * (iiScreenSize.minSide / 320)
      scrollView.contentInset.top = topMargin
    }

    // Scroll text down to show the branch on the drawing
    scrollView.contentOffset.y = -scrollView.contentInset.top
  }
}
