//
//  WalkViewController.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

class WalkViewController: UIViewController, UIAlertViewDelegate {

  @IBOutlet var quotes: YiiQuotes!

  deinit {
    println("deinit WalkViewController")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    WalkCircleMonitor.start()

    showBackground()

    quotes.setup()
    quotes.showRandomQuote()

    iiQ.runAfterDelay(3) {
      WalkNotification.registerNotifications()
    }
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    initQuotesOrientation()
    quotes.show()
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    WalkCircleMonitor.stop()
  }

  private func initQuotesOrientation() {
    let interfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
    quotes.adjustToNewSize(interfaceOrientation)
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }

  // DEPRECATION WARNING: Remove this function when iOS7 support is dropped
  override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation,
    duration: NSTimeInterval) {

    super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)

    quotes.adjustToNewSize(toInterfaceOrientation)
  }
  
  @IBAction func onCancelTapped(sender: AnyObject) {
    showConfirmDialog()
  }

  private func showConfirmDialog() {
    let alert = UIAlertView(title: "",
    message: "Abandon this walk?",
    delegate: self, cancelButtonTitle: nil, otherButtonTitles: "Yes", "No")
    alert.cancelButtonIndex = 1
    alert.show()
  }

  private func showBackground() {
    let image = UIImage(named: "branch_background.jpg")
    let imageView = UIImageView(image: image)
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
    view.insertSubview(imageView, atIndex: 0)

    iiAutolayoutConstraints.fillParent(imageView, parentView: view, margin: 0, vertically: true)
    iiAutolayoutConstraints.fillParent(imageView, parentView: view, margin: 0, vertically: false)
  }
}

// UIAlertViewDelegate
// ------------------------

typealias WalkViewController_alertViewDelegateImplementation = WalkViewController

extension WalkViewController_alertViewDelegateImplementation {
  // UIAlertViewDelegate
  // ------------------------
  func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    if buttonIndex == 0 {
      WalkViewControllers.Map.show()
    }
  }
}
