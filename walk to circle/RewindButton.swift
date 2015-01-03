//
//  RewindButton.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 19/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class RewindButton: UIButton {
  private let countdownLabel = UILabel()

  private let iiLabelFont = UIFont.systemFontOfSize(40)
  private let arrowsLayer = CALayer()

  required init(coder aDecoder: NSCoder) {

    super.init(coder: aDecoder)

    initLabel()
    initArrows()

    // Arrows do not rotate without this first time after app is launched
    iiQ.runAfterDelay(0.1) {
      self.animateArrows()
    }

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
  }

  func applicationWillEnterForeground(notification: NSNotification) {
    // Animation was removed when application was in background
    // Recreate arrow animation
    animateArrows()
  }

  func updateText(text: String) {
    let attributedText = NSAttributedString(string: text, attributes: [
      NSForegroundColorAttributeName: WalkColors.ButtonTextColor.uiColor,
      NSFontAttributeName: iiLabelFont,
      NSTextEffectAttributeName: NSTextEffectLetterpressStyle
    ])

    countdownLabel.attributedText = attributedText
  }

  private func initLabel() {
    countdownLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

    RewindButton.positionContdownLabel(self, label: countdownLabel)
  }

  private func initArrows() {
    iiLayer.loadImage(inLayer: arrowsLayer, imageName: "rewind_arrows")
    iiLayer.centerInParent_withSizeOfParent(arrowsLayer, parentBounds: bounds)
    self.layer.addSublayer(arrowsLayer)
  }

  private func animateArrows() {
    RewindButton.rotateArrows(arrowsLayer)
  }

  private class func rotateArrows(layer: CALayer) {
    iiAnimator.addInfiniteAnimation(layer, keyPath: "transform.rotation.z",
      fromVaue: 0, toValue: -2*M_PI-0.001, duration: 2, autoreverses: false)
  }

  private class func positionContdownLabel(superview: UIView, label: UILabel) {
    superview.addSubview(label)

    superview.addConstraint(NSLayoutConstraint(
      item: superview,
      attribute: NSLayoutAttribute.CenterX,
      relatedBy: NSLayoutRelation.Equal,
      toItem: label,
      attribute: NSLayoutAttribute.CenterX,
      multiplier: 1,
      constant: 0))

    superview.addConstraint(NSLayoutConstraint(
      item: superview,
      attribute: NSLayoutAttribute.CenterY,
      relatedBy: NSLayoutRelation.Equal,
      toItem: label,
      attribute: NSLayoutAttribute.CenterY,
      multiplier: 1,
      constant: 0))
  }
}
