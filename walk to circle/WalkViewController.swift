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

    if let currentCoordinate = WalkCoordinate.current {
      WalkRegions.startMonitoringForCoordinate(currentCoordinate)
    }
  }
  
  @IBAction func onCancelTapped(sender: AnyObject) {
    WalkViewControllers.Map.show()
  }
}
