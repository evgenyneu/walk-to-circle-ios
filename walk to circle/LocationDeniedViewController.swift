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

    if iiSettingsOpener.canOpenAppSettings {
      iiViewPosition.hide(settingsInstructionLabel)
    } else {
      openAppSettingsButton.removeFromSuperview()
    }
  }

  @IBAction func onOpenAppSettingsTapped(sender: AnyObject) {
    iiSettingsOpener.openSettings()
  }
}