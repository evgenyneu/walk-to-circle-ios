//
//  ButtonAnimator.swift
//  
//  Helper functions for animation.
//
//  Created by Evgenii Neumerzhitckii on 7/09/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import QuartzCore

let iiButtonRotateAnimationDuration = 0.5

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

  class func rotate3dOut(view: UIView, onFinished: (()->())? = nil) {
    rotateX3d(view, fromAngle: 0, toAngle: M_PI, onFinished)
    view.layer.zPosition = 1000
  }

  class func rotate3dIn(view: UIView, onFinished: (()->())? = nil) {
    rotateX3d(view, fromAngle: -M_PI, toAngle: 0, onFinished)
    view.layer.zPosition = 999
  }

  class func rotateX3d(view: UIView, fromAngle: Double, toAngle: Double, onFinished: (()->())? = nil) {
    view.userInteractionEnabled = false

    var transform = CATransform3DIdentity
    transform.m34 = -1.0/100.0

    view.layer.transform = CATransform3DRotate(transform, CGFloat(toAngle), 1, 0, 0)

    CATransaction.begin()
    var rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.x")
    rotationAnimation.fromValue = NSNumber(double: fromAngle)
    rotationAnimation.toValue = NSNumber(double: toAngle)
    rotationAnimation.duration = iiButtonRotateAnimationDuration;
    CATransaction.setCompletionBlock(onFinished)
    view.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    CATransaction.commit()
  }
}