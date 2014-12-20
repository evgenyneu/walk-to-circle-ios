//
//  LocationServicesDeniedViewController.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 20/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class LocationDeniedViewController: UIViewController {
  @IBOutlet weak var openAppSettingsButton: UIButton!
  @IBOutlet weak var settingsInstructionLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    if canOpenAppSettings {
      settingsInstructionLabel.text = "Please allow location access in Settings."
    } else {
      settingsInstructionLabel.text = "Please enable location services in Settings > Privacy > Location Services."
      openAppSettingsButton.removeFromSuperview()
    }
  }

  @IBAction func onOpenAppSettingsTapped(sender: AnyObject) {
    if !canOpenAppSettings { return }

    if let appSettingsUrl = NSURL(string: UIApplicationOpenSettingsURLString) {
      UIApplication.sharedApplication().openURL(appSettingsUrl)
    }
  }

  private var canOpenAppSettings: Bool {
    return iiOsVersion.version >= 8
  }
}