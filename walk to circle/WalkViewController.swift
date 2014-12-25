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

    showBackground()

    quotes.setup()
    quotes.showRandomQuote()

    if respondsToSelector(Selector("traitCollection")) {
      quotes.adjustToNewSize(traitCollection)
    }
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }

  override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {

    super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)

    quotes.adjustToNewSize(newCollection)
  }

  // DEPRECATED in iOS 8: Remove this function when iOS7 support is dropped
  override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation,
    duration: NSTimeInterval) {

    super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)

    let verticalCompact = !UIInterfaceOrientationIsPortrait(toInterfaceOrientation)
    quotes.adjustToNewSize(verticalCompact)
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
