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

  func show() {
    let options = self == WalkViewControllers.Map ? UIViewAnimationOptions.TransitionFlipFromBottom : UIViewAnimationOptions.TransitionFlipFromTop

    iiPresentViewController.replaceRootViewController(self.rawValue,
      options: options,
      duration: WalkConstants.viewControllerTransitionDuration)
  }
}