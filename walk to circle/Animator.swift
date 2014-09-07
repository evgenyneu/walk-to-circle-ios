//
//  ButtonAnimator.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 7/09/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class Animator {
  func bounce(view: UIView) {
    view.transform = CGAffineTransformMakeScale(0.1, 0.1)

    UIView.animateWithDuration(2.0,
      delay: 0,
      usingSpringWithDamping: CGFloat(0.20),
      initialSpringVelocity: CGFloat(6.0),
      options: UIViewAnimationOptions.AllowUserInteraction,
      animations: {
        view.transform = CGAffineTransformIdentity
      },
      completion: nil
    )
  }
}