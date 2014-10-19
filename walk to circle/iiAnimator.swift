//
//  ButtonAnimator.swift
//  
//  Helper functions for animation.
//
//  Created by Evgenii Neumerzhitckii on 7/09/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

let iiButtonRotateAnimationDuration = 1.0
let iiButtonFadeAnimationDuration = 0.5


class iiAnimator {
  class func bounce(view: UIView) {
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

  class func fadeIn(view: UIView) {
    view.alpha = 0

    UIView.animateWithDuration(iiButtonRotateAnimationDuration) {
      view.alpha = 1
    }
  }

  class func fadeOut(view: UIView) {
    view.alpha = 1

    UIView.animateWithDuration(iiButtonRotateAnimationDuration) {
      view.alpha = 0
    }
  }

  class func rotate3dOut(view: UIView) {
    view.userInteractionEnabled = false

    var transform = CATransform3DIdentity
    transform.m34 = -1.0/100.0

    view.layer.transform = CATransform3DRotate(transform, CGFloat(M_PI), 1, 0, 0)

    var rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.x")
    rotationAnimation.fromValue = NSNumber(double: 0)
    rotationAnimation.toValue = NSNumber(double: M_PI)
    rotationAnimation.duration = iiButtonRotateAnimationDuration;
    view.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation1")
    view.layer.zPosition = 1000
  }

  class func rotate3dIn(view: UIView) {
    view.userInteractionEnabled = false

    var transform = CATransform3DIdentity
    transform.m34 = -1.0/100.0

    view.layer.transform = CATransform3DRotate(transform, CGFloat(0), 1, 0, 0)

    var rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.x")
    rotationAnimation.fromValue = NSNumber(double: -M_PI)
    rotationAnimation.toValue = NSNumber(double: 0)
    rotationAnimation.duration = iiButtonRotateAnimationDuration;
    view.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation2")
    view.layer.zPosition = 999
  }

}