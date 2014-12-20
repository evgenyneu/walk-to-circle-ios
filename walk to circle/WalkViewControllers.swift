//
//  WalkViewControllerIds.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

enum WalkViewControllers: String {
  case Initial = "initial view controller"
  case Map = "map view controller"
  case Walk = "walk view controller"
  case Congrats = "congrats view controller"
  case LocationDenied = "location denied controller"
  case RegionMonitoringUnavailable = "region monitoring unavailable controller"

  func show() {
    if WalkViewControllers.current == self { return }

    let options = self == WalkViewControllers.Map ?
      UIViewAnimationOptions.TransitionFlipFromBottom : UIViewAnimationOptions.TransitionFlipFromTop

    iiPresentViewController.replaceRootViewController(rawValue,
      options: options,
      duration: WalkConstants.viewControllerTransitionDuration)

    WalkViewControllers.current = self
  }

  static var current: WalkViewControllers {
    get {
      let userDefaults = NSUserDefaults.standardUserDefaults()
      let defaultViewController = WalkViewControllers.Map

      if let currentViewControllerName =
        userDefaults.valueForKey(WalkConstants.userDefaultsKey_currentViewControllerId) as? String {

        return WalkViewControllers(rawValue: currentViewControllerName) ?? defaultViewController
      }

      return defaultViewController
    }

    set {
      let userDefaults = NSUserDefaults.standardUserDefaults()
      userDefaults.setValue(newValue.rawValue, forKey: WalkConstants.userDefaultsKey_currentViewControllerId)
      userDefaults.synchronize()
    }
  }
}