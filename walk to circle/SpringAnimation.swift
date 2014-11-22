//
//  SpringAnimationValues.swift
//
//  Returns array of values for CAKeyframeAnimation to achieve spring animation effect
//
//  Created by Evgenii Neumerzhitckii on 22/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class SpringAnimation {
  class func animateLayer(layer: CALayer,
    keypath: String,
    duration: CFTimeInterval,
    usingSpringWithDamping: Double,
    initialSpringVelocity: Double,
    fromValue: Double,
    toValue: Double,
    onFinished: (()->())?) {

    CATransaction.begin()
    CATransaction.setCompletionBlock(onFinished)

    let animation = create(keypath, duration: duration,
      usingSpringWithDamping: usingSpringWithDamping,
      initialSpringVelocity: initialSpringVelocity,
      fromValue: fromValue, toValue: toValue)

    layer.addAnimation(animation, forKey: keypath + " spring animation")
    CATransaction.commit()
  }

  class func create(keypath: String,
    duration: CFTimeInterval,
    usingSpringWithDamping: Double,
    initialSpringVelocity: Double,
    fromValue: Double,
    toValue: Double) -> CAKeyframeAnimation {

    let dampingMultiplier = Double(10)
    let velocityMultiplier = Double(10)

    let values = animationValues(fromValue, toValue: toValue,
      damping: dampingMultiplier * usingSpringWithDamping,
      initialVelocity: velocityMultiplier * initialSpringVelocity)

    let animation = CAKeyframeAnimation(keyPath: keypath)
    animation.values = values
    animation.duration = duration
    
    return animation
  }

  class func animationValues(fromValue: Double, toValue: Double,
    damping: Double, initialVelocity: Double) -> [Double]{

      let numOfPoints = 500
      var values = [Double](count: numOfPoints, repeatedValue: 0.0)

      let distanceBetweenValues = toValue - fromValue

      for point in (0..<numOfPoints) {
        let x = Double(point) / Double(numOfPoints)
        let valueNormalized = animationValuesNormalized(x,
          damping: damping, initialVelocity: initialVelocity)

        let value = toValue - distanceBetweenValues * valueNormalized
        values[point] = value
      }

      return values
  }

  private class func animationValuesNormalized(x: Double, damping: Double,
    initialVelocity: Double) -> Double {

    return pow(M_E, -damping * x) * cos(initialVelocity * x)
  }


}
