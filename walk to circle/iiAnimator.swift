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

  class func fadeIn(view: UIView, duration: Double) {
    view.alpha = 0

    UIView.animateWithDuration(duration) {
      view.alpha = 1
    }
  }

  class func fadeOut(view: UIView, duration: Double) {
    view.alpha = 1

    UIView.animateWithDuration(duration) {
      view.alpha = 0
    }
  }

  class func rotate3dOut(view: UIView, onFinished: (()->())? = nil) {
    springRotateX3d(view, fromAngle: 0, toAngle: M_PI, duration: 2, onFinished)
  }

  class func rotate3dIn(view: UIView, onFinished: (()->())? = nil) {
    springRotateX3d(view, fromAngle: -M_PI, toAngle: 0, duration: 2, onFinished)
  }

  class func rotate3d360(view: UIView, onFinished: (()->())? = nil) {
    springRotateX3d(view, fromAngle: 0, toAngle: 2 * M_PI, duration: 2, onFinished)
  }

  class func springRotateX3d(view: UIView,
    fromAngle: Double, toAngle: Double, duration: Double, onFinished: (()->())? = nil) {

    var transform = CATransform3DIdentity
    transform.m34 = -1.0/110.0

    view.layer.transform = CATransform3DRotate(transform, CGFloat(toAngle), 1, 0, 0)

    SpringAnimation.animate(view.layer,
      keypath: "transform.rotation.x",
      duration: duration,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 0.7,
      fromValue: fromAngle,
      toValue: toAngle,
      onFinished: onFinished)
  }

  class func addInfiniteAnimation(layer: CALayer, keyPath: String,
    fromVaue: Double, toValue: Double, duration: Double,
    autoreverses: Bool = false, cumulative: Bool = false) -> CABasicAnimation {

    let animation = createInfiniteAnimation(keyPath, fromVaue: fromVaue, toValue: toValue,
      duration: duration, autoreverses: autoreverses, cumulative: cumulative)

    layer.addAnimation(animation, forKey: keyPath)

    return animation
  }

  class func createInfiniteAnimation(keyPath: String,
    fromVaue: Double, toValue: Double, duration: Double,
    autoreverses: Bool = false, cumulative: Bool = false) -> CABasicAnimation {

    let animation = CABasicAnimation(keyPath: keyPath)
    animation.fromValue = fromVaue
    animation.toValue = toValue
    animation.duration = duration
    animation.autoreverses = autoreverses
    animation.fillMode = kCAFillModeForwards
    animation.cumulative = cumulative
    animation.repeatCount = Float.infinity

    return animation
  }
}