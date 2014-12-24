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
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    showBackground()
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  @IBAction func onCancelTapped(sender: AnyObject) {
    showConfirmDialog()
  }

  private func showConfirmDialog() {
    let alert = UIAlertView(title: "",
    message: "Stop current walk?",
    delegate: self, cancelButtonTitle: nil, otherButtonTitles: "Yes", "No")
    alert.cancelButtonIndex = 1
    alert.show()
  }

  private func showBackground() {
    let image = UIImage(named: "branch_background_1242_2208.png")
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
