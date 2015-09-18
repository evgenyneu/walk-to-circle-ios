//
//  iiSettingsOpener.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 25/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class iiSettingsOpener {
  class func openSettings() {
    if !canOpenAppSettings { return }

    if let appSettingsUrl = NSURL(string: UIApplicationOpenSettingsURLString) {
      UIApplication.sharedApplication().openURL(appSettingsUrl)
    }
  }

  class var canOpenAppSettings: Bool {
    return iiOsVersion.version >= 8
  }
}
