//
//  CongratsViewController.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

class CongratsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func onDoneTapped(sender: AnyObject) {
    iiPresentViewController.replaceRootViewController(WalkViewControllerIds.Map.rawValue,
      options: .TransitionFlipFromBottom,
      duration: WalkConstants.viewControllerTransitionDuration
    )
  }
}