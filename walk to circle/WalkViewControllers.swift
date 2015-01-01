//
//  WalkViewControllerIds.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

enum WalkViewControllers: String {
  case InitialDummy = "initial view controller"
  case Map = "map view controller"
  case Walk = "walk view controller"
  case Congrats = "congrats view controller"

  // Error view controllers
  case LocationDenied = "location denied controller"
  case RegionMonitoringUnavailable = "region monitoring unavailable controller"

  func show(animate: Bool = true) {
    if WalkViewControllers.controllerPresented && WalkViewControllers.current == self {
      // This view controller is already being shown
      return
    }

    let options = self == WalkViewControllers.Map ?
      UIViewAnimationOptions.TransitionFlipFromBottom : UIViewAnimationOptions.TransitionFlipFromTop

    if WalkViewControllers.controllerPresented && animate {
      iiPresentViewController.replaceRootViewController(rawValue,
        options: options,
        duration: WalkConstants.viewControllerTransitionDuration)
    } else {
      // No controller was presented yet. Currentl root view controller is a blank dummy
      // Replace it with new controller without animation.
      iiPresentViewController.setRootViewController(rawValue)
    }

    WalkViewControllers.controllerPresented = true
    WalkViewControllers.current = self
  }

  // If root view controller was presented yet
  static private(set) var controllerPresented = false

  static var current: WalkViewControllers {
    get {
      let defaultViewController = WalkViewControllers.Map

      if let currentViewControllerName = WalkUserDefaults.currentViewControllerId.value as? String {
        return WalkViewControllers(rawValue: currentViewControllerName) ?? defaultViewController
      }

      return defaultViewController
    }

    set {
      WalkUserDefaults.currentViewControllerId.save(newValue.rawValue)

      if !newValue.errorViewController {
        WalkUserDefaults.currentNonErrorViewControllerId.save(newValue.rawValue)
      }
    }
  }

  static var currentNonError: WalkViewControllers {
    get {
      let defaultViewController = WalkViewControllers.Map

      if let currentViewControllerName = WalkUserDefaults.currentNonErrorViewControllerId.value as? String {
        return WalkViewControllers(rawValue: currentViewControllerName) ?? defaultViewController
      }

      return defaultViewController
    }
  }

  var errorViewController: Bool {
    let errorViewControllers = [
      WalkViewControllers.LocationDenied,
      WalkViewControllers.RegionMonitoringUnavailable]

    return contains(errorViewControllers, self)
  }
}