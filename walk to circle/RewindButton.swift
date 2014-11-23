//
//  RewindButton.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 19/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import QuartzCore

class RewindButton: UIButton {

  private let countdownLabel = UILabel()

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    initLabel()
    showArrows()
  }

  private func initLabel() {
    let font = UIFont.systemFontOfSize(40)
    let textColor = UIColor(red: 255 / 255, green: 217 / 255, blue: 14 / 255, alpha: 0.4)

    let attributedText = NSAttributedString(string: "60", attributes: [
      NSForegroundColorAttributeName: textColor,
      NSFontAttributeName: font,
      NSTextEffectAttributeName: NSTextEffectLetterpressStyle
      ])

    countdownLabel.attributedText = attributedText
    countdownLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    RewindButton.positionContdownLabel(self, label: countdownLabel)
  }

  private func showArrows() {
    let arrowsLayer = CALayer()
    iiLayer.loadImage(inLayer: arrowsLayer, imageName: "rewind_arrows")
    iiLayer.centerInParent_withSizeOfParent(arrowsLayer, parentBounds: bounds)
    self.layer.addSublayer(arrowsLayer)

    RewindButton.rotateArrows(arrowsLayer)
  }

  private class func rotateArrows(layer: CALayer) {
    iiAnimator.addInfiniteAnimation(layer, keyPath: "transform.rotation.z",
      fromVaue: 0, toValue: -M_PI, duration: 1, autoreverses: false)

    iiAnimator.addInfiniteAnimation(layer, keyPath: "transform.rotation.y",
      fromVaue: 0, toValue: M_PI / 6, duration: 1.3, autoreverses: true)
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
