//
//  WalkViewController.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

class WalkViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    if let currentApp = AppDelegate.current {
      if let regionCoordinate = currentApp.circleCoordinate {
        WalkRegions.startMonitoringForCoordinate(regionCoordinate)
      }
    }
  }
  
  @IBAction func onCancelTapped(sender: AnyObject) {
    WalkViewControllers.Map.show()
  }
}
